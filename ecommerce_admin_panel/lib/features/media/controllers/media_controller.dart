import 'package:ecommerce_admin_panel/common/widgets/loaders/circular_loader.dart';
import 'package:ecommerce_admin_panel/data/repositories/media/media_repository.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_content.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;
  final int initialLoadCount = 20;
  final int loadMoreCount = 25;
  late DropzoneViewController dropzoneController;
  final RxBool showImageUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final RxList<ImageModel> allAppImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository.instance;

  // Get Images
  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners && allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands && allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories && allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products && allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users && allUserImages.isEmpty) {
        targetList = allUserImages;
      } else if (selectedPath.value == MediaCategory.app && allAppImages.isEmpty) {
        targetList = allAppImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(selectedPath.value, initialLoadCount);
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      if(kDebugMode )print("Error in getMediaImages : ${e.toString()}");
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Oh snap",
          message: "Unable to fetch images, Something went wrong. Try again");
    }
  }

  // load more Images
  void loadMoreImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users) {
        targetList = allUserImages;
      }else if (selectedPath.value == MediaCategory.app) {
        targetList = allAppImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          initialLoadCount,
          targetList.last.createdAt ?? DateTime.now());
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Oh snap",
          message:
              "Unable to load more images, Something went wrong. Try again");
    }
  }

  /// Select Local Images on Button Press
  Future<void> selectLocalImages() async {
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);
    if (files.isNotEmpty) {
      for (var file in files) {
        // Retrieve file data as Uint8List
        final bytes = await dropzoneController.getFileData(file);
        // Extract file metadata
        final filename = await dropzoneController.getFilename(file);
        final mimeType = await dropzoneController.getFileMIME(file);
        final image = ImageModel(
          url: '',
          folder: '',
          fileName: filename,
          contentType: mimeType,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: "Select Folder",
          message: "Please select the Folder in Order to upload images");
      return;
    }
    TDialogs.defaultDialog(
        context: Get.context!,
        title: 'Upload Images',
        confirmText: 'Upload',
        onConfirm: () async => await uploadImages(),
        content:
            "Are you sure you want to upload all the images in ${selectedPath.value.name.toUpperCase()} folder?");
  }

  /// Upload Images
  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();
      // Start Loader
      uploadImagesLoader();
      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;
      // Get the corresponding list to update
      RxList<ImageModel> targetList;
      // Check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
        case MediaCategory.app:
          targetList = allAppImages;
          break;
        default:
          return;
      }
      // Upload and add images to the target list
      // Using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        // Upload Image to the Storage
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
          fileData: selectedImage.localImageToDisplay!,
          mimeType: selectedImage.contentType!,
          path: getSelectedPath(),
          imageName: selectedImage.fileName,
        );
        // Upload Image to the Firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }
      // Stop Loader after successful upload
      TFullScreenLoader.stopLoading();
    } catch (e) {
      // Stop Loader in case of an error
      TFullScreenLoader.stopLoading();
      // Show a warning snack-bar for the error
      TLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'Something went wrong while uploading your images.');
    }
  }

  void uploadImagesLoader() {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text("Uploading Images"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(TImages.uploadingImageIllustration,
                      height: 300, width: 300),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Text('Sit Tight, Your images are uploading...')
                ],
              ),
            )));
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = "Others";
    }
    return path;
  }

  // Popup confirmation to remove cloud image
  void removeCloudImageConfirmation(ImageModel image) {
    TDialogs.defaultDialog(
      context: Get.context!,
      content: "Are you sure you want to delete this image?",
      onConfirm: () {
        // Close the previous Dialogue   image popup
        Get.back();

        removeCLoudImage(image);
      },
    );
  }

  Future<void> removeCLoudImage(ImageModel image) async {
    try {
      // Close the removeCloudImageConfirmation() Dialogue
      Get.back();
      Get.defaultDialog(
          title: "",
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: PopScope(
              canPop: false,
              child: SizedBox(
                width: 150,
                height: 150,
                child: TCircularLoader(),
              )));

      // Delete Image
      await mediaRepository.deleteFileFromStorage(image);

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allBannerImages;
          break;
        default:
          return;
      }

      // Remove from the list
      targetList.remove(image);
      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Image Deleted",
          message: "Image successfully deleted from cloud storage");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFromMedia(
      {List<String>? selectedUrls,
      bool allowSelection = true,
      bool multipleSelection = false}) async {
    showImageUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
        isScrollControlled: true,
        backgroundColor: TColors.primaryBackground,
        FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  MediaUploader(),
                  MediaContent(
                      allowSelection: allowSelection,
                      allowMultipleSelection: multipleSelection,
                      alreadySelectedUrls: selectedUrls ?? [])
                ],
              ),
            ),
          ),
        ));
    return selectedImages;
  }
}
