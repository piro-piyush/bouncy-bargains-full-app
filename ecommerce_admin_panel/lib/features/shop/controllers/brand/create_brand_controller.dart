import 'package:ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateBrandController extends GetxController {

  static CreateBrandController get instance => Get.find();

  final BrandRepository _repo = BrandRepository.instance;
  final BrandController  brandController = BrandController.instance;
  final CategoryController categoryController = CategoryController.instance;

  final isLoading = false.obs;
  RxString imageUrl = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Method to reset fields;
  void resetFields() {
    name.clear();
    isLoading(false);
    isFeatured(false);
    imageUrl.value = "";
    selectedCategories.clear();
  }

  // Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = MediaController.instance;
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected Images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected images to the main page or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageUrl.value = selectedImage.url;
    }
  }

  // Register new Brand
  Future<void> createBrand() async {
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
      final newRecord = BrandModel(
        id: "",
        productsCount: 0,
        name: name.text.trim(),
        image: imageUrl.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      // Call Repo to create new Brand
      newRecord.id = await _repo.createBrand(newRecord);

      // Register brand categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing relational data. Try again.';
        }

        // Loop selected Brand Categories
        for (var category in selectedCategories) {
          // Map Data
          final brandCategory = BrandCategoryModel(
              brandId: newRecord.id, categoryId: category.id);
          await _repo.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update All Data List
      brandController.addItemToList(newRecord);

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
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }
}
