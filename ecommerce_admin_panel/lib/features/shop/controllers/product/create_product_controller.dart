import 'package:ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  // Obx for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controller and keys
  final stockFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();
  final _repo = Get.put(ProductRepository());

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and category
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different states
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Function to create a new product
  Future<void> createProduct() async {
    try {
      // Show Progress Dialog
      showProgressDialog();

      // Check Internet Connection
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
        final variationCheckFailed = ProductVariationsController
            .instance.productVariations
            .any((element) =>
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
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw "Select thumbnail image";
      }

      // additional product images
      additionalImagesUploader.value = true;
      final variations = ProductVariationsController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations and then  changed the product type, remove all variations
        ProductVariationsController.instance.resetAllValues();
        variations.value = [];
      }

      // Map product data to  product model
      final newRecord = ProductModel(
          id: "",
          sku: "",
          isFeatured: true,
          title: title.text.trim(),
          brand: selectedBrand.value,
          productVariations: variations,
          description: description.text.trim(),
          productType: productType.value.toString(),
          stock: int.tryParse(stock.text.trim()) ?? 0,
          price: double.tryParse(price.text.trim()) ?? 0,
          salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
          images: imagesController.additionalProductImageUrls,
          thumbnail: imagesController.selectedThumbnailImageUrl.value ?? "",
          productAttributes: ProductAttributesController.instance.productAttributes,
          date: DateTime.now());

      // Call repo to create product
      productDataUploader.value = true;
      newRecord.id = await _repo.createProduct(product: newRecord);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw "Error storing data. Try again";

        // Loop through selected categories and register
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Map Data
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category.id);
          await _repo.createProductCategory(productCategory: productCategory);
        }
      }

      // Update the product list
      ProductController.instance.addItemToList(newRecord);

      // CLose the progress loader
      TFullScreenLoader.stopLoading();
      Get.back();
      // Show success message
      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void showProgressDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) => PopScope(
            child: AlertDialog(
                title: Text("Creating Product"),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(
                    TImages.creatingProductIllustration,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  buildCheckBox("Thumbnail Image", thumbnailUploader),
                  buildCheckBox("Additional Image", additionalImagesUploader),
                  buildCheckBox("Product Data, Attributes & Variations",
                      productDataUploader),
                  buildCheckBox(
                      "Product Categories", categoriesRelationshipUploader),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text("Sit Tight , We are creating your product"),
                ]))));
  }

  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: const Text("Congratulations"),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Go to products"),
        )
      ],
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset(
          TImages.productsIllustration,
          height: 200,
          width: 200,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text("Congratulations",
            style: Theme.of(Get.context!).textTheme.headlineSmall),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text("Your product has been created successfully")
      ]),
    ));
  }

  Widget buildCheckBox(String label, RxBool value) {
    return Row(children: [
      AnimatedSwitcher(
        duration: Duration(seconds: 2),
        child: value.value
            ? Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Colors.blue)
            : Icon(
                CupertinoIcons.checkmark_alt_circle,
              ),
      ),
      SizedBox(width: TSizes.spaceBtwItems),
      Text(label)
    ]);
  }

  void resetValues() {
    isLoading.value = false;
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
    ProductVariationsController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();
    ProductImagesController.instance.resetAllImages();
    // Reset upload flags
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }
}
