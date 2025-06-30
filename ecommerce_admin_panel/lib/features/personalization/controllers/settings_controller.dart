import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ⚙️ SettingsController
///
/// Controls application-wide settings in the Admin Panel.
/// - Loads settings from Firestore
/// - Updates settings including app name, logo, tax rate, etc.
/// - Integrates media controller for logo management
class SettingsController extends GetxController {
  /// Singleton instance via GetX
  static SettingsController get instance => Get.find();

  /// Repository for Firebase operations
  final _repo = Get.put(SettingsRepository());

  /// Reactive loading indicator for UI feedback
  final RxBool loading = false.obs;

  /// Reactive settings data model
  final Rx<SettingsModel> settings = SettingsModel().obs;

  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  //─────────────────────────────────────
  // Form Controllers
  final appNameController = TextEditingController();
  final taxRateController = TextEditingController();
  final shippingCostController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  //─────────────────────────────────────

  /// Called on controller initialization
  @override
  void onInit() {
    super.onInit();
    fetchSettingsDetails();
  }

  /// 🔄 Fetches settings from Firestore and populates form fields
  Future<SettingsModel> fetchSettingsDetails() async {
    try {
      loading.value = true;

      final fetchedSettings = await _repo.getSettings();
      settings.value = fetchedSettings;

      // Set initial form field values
      appNameController.text = fetchedSettings.appName;
      taxRateController.text = fetchedSettings.taxRate.toString();
      shippingCostController.text = fetchedSettings.shippingCost.toString();
      freeShippingThresholdController.text =
          fetchedSettings.freeShippingThreshold?.toString() ?? "";

      return fetchedSettings;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
      return SettingsModel(); // fallback empty model
    } finally {
      loading.value = false;
    }
  }

  /// 🖼️ Pick and update app logo using MediaController
  Future<void> updateAppLogo() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No internet connection. Please check your connection.",
        );
      }

      loading.value = true;

      final List<ImageModel>? selectedImages = await MediaController.instance.selectImagesFromMedia();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        final ImageModel selectedImage = selectedImages.first;

        // Update logo URL in Firestore
        await _repo.updateSingleField({'appLogo': selectedImage.url});

        // Reflect in UI
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        TLoaders.successSnackBar(
            title: "Success", message: "App logo updated successfully.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Failed", message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// 💾 Validates and updates all settings to Firestore
  Future<void> updateSettingsInfo() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No internet connection. Please check your connection.",
        );
      }

      // Validate form
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final appName = appNameController.text.trim();
      final taxRate = double.parse(taxRateController.text.trim());
      final shippingCost = double.parse(shippingCostController.text.trim());
      final freeShippingThreshold = double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      // Check if any value has changed
      final hasChanged =
          settings.value.appName != appName ||
              settings.value.taxRate != taxRate ||
              settings.value.shippingCost != shippingCost ||
              settings.value.freeShippingThreshold != freeShippingThreshold;
      if (!hasChanged) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "No Changes",
          message: "All settings are already up to date.",
        );
        return;
      }
      // ✅ Update only if values changed
      settings.value.appName = appName;
      settings.value.taxRate = taxRate;
      settings.value.shippingCost = shippingCost;
      settings.value.freeShippingThreshold = freeShippingThreshold;
      loading.value = true;
      // Push to Firestore
      await _repo.updateSettings(settings.value);
      settings.refresh();
      TLoaders.successSnackBar(title: "Success", message: "Settings updated successfully.");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Update Failed", message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
