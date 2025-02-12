import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageUrl = ''.obs;
  final RxString targetScreen = "".obs;
  final isActive = false.obs;
  final loading = false.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  /// Init Data
  void init(BannerModel banner) {
    imageUrl.value = banner.imageUrl;
    targetScreen.value = banner.targetScreen;
    isActive.value = banner.active;
  }

  /// Pick Thumbnail Images from media.
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    // Handle the selected Images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected images to the main page or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageUrl.value = selectedImage.url;
    }
  }

  void resetFields() {
    imageUrl.value = "";
    targetScreen.value = "";
    isActive.value = false;
  }

  /// Update banner
  Future<void> updateBanner(BannerModel banner) async {
    try {
      // Start Loading
      TFullScreenLoader.popUpCircular();

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Is Data Updated
      if (banner.imageUrl != imageUrl.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {
        // Map Data
        banner.imageUrl = imageUrl.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        // Call repo to update banner
        await repository.updateBanner(banner: banner);
      }

      // Update the List
      BannerController.instance.updateItemFromList(banner);

      // // Reset Fields
      // resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Navigate Back
      Get.back();

      // Success Message & Redirect
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'New record has been updated.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }
}
