import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  // Rx Observables for the selected thumbnail images
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // List to store additional product images
  final RxList<String> additionalProductImageUrls = <String>[].obs;

  // Pick Thumbnail Image from media
  void selectedThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selected image
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  // Pick Multiple Images from media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia(
        multipleSelection: true, selectedUrls: additionalProductImageUrls);

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImageUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selected image
      variation.image.value = selectedImage.url;
    }
  }

  // Remove Image
  Future<void> removeImage(int index) async {
    additionalProductImageUrls.removeAt(index);
  }


  // Reset Thumbnail Image
  void resetThumbnailImage() {
    selectedThumbnailImageUrl.value = null;
  }

  // Reset Additional Product Images
  void resetAdditionalImages() {
    additionalProductImageUrls.clear();
  }

  // Reset All Images
  void resetAllImages({List<ProductVariationModel>? variations}) {
    resetThumbnailImage();
    resetAdditionalImages();

    // Reset variation images if list provided
    if (variations != null) {
      for (var variation in variations) {
        variation.image.value = '';
      }
    }
  }
}
