import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Obx Var
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxRateController = TextEditingController();
  final shippingCostController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  final _repo = Get.put(SettingsRepository());

  @override
  void onInit() {
    super.onInit();
    // Fetch settings details on initialization
    fetchSettingsDetails();
  }

  /// Fetch settings details from the repo
  Future<SettingsModel> fetchSettingsDetails() async {
    try {
      loading.value = true;
      final settings = await _repo.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxRateController.text = settings.taxRate.toString();
      shippingCostController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ""
              : settings.freeShippingThreshold.toString();
      loading.value = false;
      return settings;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
      return SettingsModel();
    }finally{
      loading.value = false;
    }
  }

  /// Pick thumbnail app image from media
  void updateAppLogo() async {
    try {
      loading.value = true;

      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the  selected image to the main logo  or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update app logo in the firestore
        await _repo.updateSingleField({
          'appLogo': selectedImage.url,
        });

        // Update the main image using the selected image
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        TLoaders.successSnackBar(
            title: "Congratulations", message: "App Logo has been updated.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
    }
  }

  void updateSettingsInfo() async {
    try {
      // Check the internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      loading.value = true;
      settings.value.appName = appNameController.text;
      settings.value.taxRate = double.parse(taxRateController.text);
      settings.value.shippingCost = double.parse(shippingCostController.text);
      settings.value.freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;
      await _repo.updateSettings(settings.value);
      settings.refresh();
      loading.value = false;
      TLoaders.successSnackBar(
          title: "Congratulations", message: "Settings has been updated.");
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
    }
  }
}
