import 'package:ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final _repo = ProductRepository.instance;
  final productController = ProductController.instance;
  final productVariationController = ProductVariationsController.instance;
  final productAttributeController = ProductAttributesController.instance;
  final productImagesController = ProductImagesController.instance;
  final categoryController = CategoryController.instance;

  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  final stockFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  /// Init data
  void init(ProductModel product) {
    try {
      isLoading.value = true;

      // Basic Info
      title.text = product.title;
      description.text =
          product.description != null ? product.description! : "";
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? "";

      // Product Thumbnail and Images
      if (product.images != null) {
        // Set the first  image as the thumbnail
        productImagesController.selectedThumbnailImageUrl.value =
            product.thumbnail;
        // Add  the images to additional product images
        productImagesController.additionalProductImageUrls
            .assignAll(product.images ?? []);
      }

      // Product Attributes & Variations  (assuming you have  a method to fetch  variations in ProductVariationController )
      productAttributeController.productAttributes
          .assignAll(product.productAttributes ?? []);
      productVariationController.productVariations
          .assignAll(product.productVariations ?? []);
      productVariationController
          .initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = true;

      update();
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;
    // Product Categories
    final productCategories = await _repo.getProductCategories(productId);
    final categoriesController = CategoryController.instance;
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoriesController.allItems
        .where((c) => categoriesIds.contains(c.id))
        .toList();
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  /// Reset Fields
  void resetValues() {
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    description.clear();
    brandTextField.clear();
    selectedCategories.clear();
    selectedBrand.value = null;
    productVariationController.resetAllValues();
    productAttributeController.resetProductAttributes();
    productImagesController.resetAllImages();
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  /// Show Progress Dialog
  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => PopScope(
        child: AlertDialog(
          title: Text("Updating Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(TImages.creatingProductIllustration,
                  height: 200, width: 200),
              SizedBox(height: TSizes.spaceBtwItems),
              buildCheckBox("Thumbnail Image", thumbnailUploader),
              buildCheckBox("Additional Images", additionalImagesUploader),
              buildCheckBox(
                  "Product Data, Attributes & Variations", productDataUploader),
              buildCheckBox(
                  "Product Categories", categoriesRelationshipUploader),
              SizedBox(height: TSizes.spaceBtwItems),
              Text("Hang tight, we're updating your product..."),
            ],
          ),
        ),
      ),
    );
  }

  /// Show Completion Dialog
  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: const Text("Congratulations"),
      actions: [
        TextButton(
          onPressed: () {
            // Get.back();
            Get.back();
          },
          child: const Text("Go to products"),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(TImages.productsIllustration, height: 200, width: 200),
          SizedBox(height: TSizes.spaceBtwItems),
          Text("Congratulations",
              style: Theme.of(Get.context!).textTheme.headlineSmall),
          SizedBox(height: TSizes.spaceBtwItems),
          Text(
            "Your Product has been updated",
          ),
        ],
      ),
    ));
  }

  /// Build Checkbox Widget
  Widget buildCheckBox(String label, RxBool value) {
    return Row(children: [
      AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: value.value
            ? Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
            : Icon(CupertinoIcons.checkmark_alt_circle),
      ),
      SizedBox(width: TSizes.spaceBtwItems),
      Text(label),
    ]);
  }

  /// Update Product in Firestore
  Future<void> updateProduct(ProductModel product) async {
    try {
      showProgressDialog();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate  title and description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate stock and pricing form if ProductType = Single
      if (productType.value == ProductType.single &&
          !stockFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Ensure  a brand is selected
      if (selectedBrand.value == null) {
        throw 'Select Brand for this product';
      }

      // Check variation data if ProductType = Variable
      if (productType.value == ProductType.variable) {
        final variationCheckFailed =
            productVariationController.productVariations.any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFailed) {
          throw "Variation data is not accurate. Please recheck variations";
        }
      }

      // Upload Product thumbnail image
      thumbnailUploader.value = true;
      if (productImagesController.selectedThumbnailImageUrl.value == null) {
        throw "Select thumbnail image";
      }

      // additional product images
      additionalImagesUploader.value = true;
      final variations = productVariationController.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then  changed the product type, remove all variations
        productVariationController.resetAllValues();
        variations.value = [];
      }

      product.sku = "";
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail =
          productImagesController.selectedThumbnailImageUrl.value ?? "";
      product.productAttributes = productAttributeController.productAttributes;
      product.productVariations = variations;

      productDataUploader.value = true;
      await _repo.updateProduct(product: product);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        // Loop through selected categories and register
        categoriesRelationshipUploader.value = true;

        List<String> existingCategoryIds =
            alreadyAddedCategories.map((e) => e.id).toList();
        for (var category in selectedCategories) {
          // Check if the category is not already associated with the product
          if (!existingCategoryIds.contains(category.id)) {
            // Map Data
            final productCategory = ProductCategoryModel(
                productId: product.id, categoryId: category.id);
            await _repo.createProductCategory(productCategory: productCategory);
          }
        }

        // Remove categories not selected by the user
        for (var existingCategoryId in existingCategoryIds) {
          if (!selectedCategories
              .any((element) => element.id == existingCategoryId)) {
            // Remove the association
            await _repo.removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      // Update the product list
      productController.updateItemFromList(product);

      // CLose the progress loader
      TFullScreenLoader.stopLoading();
      Get.back();
      resetValues();
      // Show success message
      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
