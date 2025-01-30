import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final isLoading = false.obs;
  RxString imageUrl = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Method to reset fields;
  void resetFields() {
    selectedParent(CategoryModel.empty());
    isLoading(false);
    isFeatured(false);
    name.clear();
    imageUrl.value = "";
  }

  // Pick Thumbnail Image from Media
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

  // Register new Category
  Future<void> createCategory() async {
    try {
      // Start Loading
      TFullScreenLoader.popUpCircular();

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      final newRecord = CategoryModel(
        id: "",
        name: name.text.trim(),
        image: imageUrl.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectedParent.value.id,
      );

      newRecord.id = await CategoryRepository.instance
          .createCategory(categoryModel: newRecord);

      // Update All Data List
      CategoryController.instance.addItemToList(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Back
      Get.back();

      // Success message & Redirect
      TLoaders.successSnackBar(
          title: "Congratulations", message: "New record has been added");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString);
    }
  }
}
