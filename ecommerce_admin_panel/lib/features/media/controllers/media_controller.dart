import 'dart:typed_data';

import 'package:ecommerce_admin_panel/data/repositories/media/media_repository.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

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

  final MediaRepository mediaRepository = MediaRepository();

  Future<void> selectLocalImages() async {
    final files = await dropzoneController
        .pickFiles(multiple: true, mime: ['images/jpeg', 'images/png']);
    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneController.getFileData(file);
        final image = ImageModel(
            url: '',
            file: html.File(bytes, file.name),
            folder: 'folder',
            fileName: file.name,
            localImageToDisplay: Uint8List.fromList(bytes));
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

  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();
      // Loader
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
        case MediaCategory.folders:
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
          break;
        default:
          return;
      }

      // Upload and add Images to the target list

      // Using a reverse loop to avoid 'Concurrent Modification during Iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;

        // Upload image to the firestore
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
                file: image,
                path: getSelectedPath(),
                imageName: selectedImage.fileName);

        // Upload Image to the Firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;
        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }

      // Stop load after successful upload
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: "Error uploading Images",
          message: "Something went wrong while uploading your images.");
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
}
