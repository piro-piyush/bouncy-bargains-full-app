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

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final BrandRepository _repo = BrandRepository.instance;
  final BrandController brandController = BrandController.instance;
  final CategoryController categoryController = CategoryController.instance;

  final isLoading = false.obs;
  RxString imageUrl = "".obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    isFeatured.value = brand.isFeatured;
    imageUrl.value = brand.image;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

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

  // Register new brand
  Future<void> updateBrand(BrandModel brand) async {
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

      // Is Data updated
      bool isBrandUpdated = false;
      if (brand.image != imageUrl.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;
        // Map Data
        brand.image = imageUrl.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call the repo to update brand
        await _repo.updateBrand(brand);
      }

      // Update Brand Categories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // update brand data in products
      if (isBrandUpdated) await updateBrandInProducts(brand);

      // Update all the list
      brandController.updateItemFromList(brand);

      // Reset Form
      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Back
      Get.back();

      // Success message & Redirect
      TLoaders.successSnackBar(
          title: "Congratulations", message: "Your record has been updated");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh snap!", message: e.toString());
    }
  }

  // Update categories of this brand
  Future<void> updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories = await _repo.getCategoriesOfSpecificBrand(brand.id);

    // SelectedCategoryIDs
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // Identity Category to remove
    final categoriesToRemove = brandCategories
        .where((existingCategory) =>
            !selectedCategoryIds.contains(existingCategory.categoryId))
        .toList();

    // remove unselected categories
    for (var category in categoriesToRemove) {
      await _repo.deleteBrandCategory(category.id ?? "");
    }

    // Identify new categories to add
    final newCategoriesToAdd = selectedCategories
        .where((category) => !brandCategories.any(
            (existingCategory) => existingCategory.categoryId == category.id))
        .toList();

    // Add new categories
    for (var category in newCategoriesToAdd) {
      var brandCategory =
          BrandCategoryModel(brandId: brand.id, categoryId: category.id);
      brandCategory.id =
          await _repo.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    brandController.updateItemFromList(brand);
  }

  // Update Products of this brand
  Future<void> updateBrandInProducts(BrandModel brand) async {}
}
