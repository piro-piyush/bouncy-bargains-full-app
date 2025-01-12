import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/view_image_details.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedUrls,
      this.onImageSelected});

  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedUrls;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelection = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Media Images Header
          Row(
            children: [
              Text(
                "Gallery Folders",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                    controller.getMediaImages();
                  }
                },
              ),
              if (allowSelection) buildSelectedImagesButton()
            ],
          ),

          // Show Media
          Obx(() {
            // Get Selected Folder Images
            List<ImageModel> images = _getSelectedFolderImages(controller);

            // Load the selected images from the already selected images only once otherwise
            // on Obx() rebuild ui first image will be selected then will auto uncheck

            if (!loadedPreviousSelection) {
              if (alreadySelectedUrls != null &&
                  alreadySelectedUrls!.isNotEmpty) {
                // Convert the alreadySelectedUrls to a set for faster lookup
                final selectedUrlsSet = Set<String>.from(alreadySelectedUrls!);
                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                // If alreadySelectedUrls is null or empty , set all images to not selected
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelection = true;
            }

            // Loader
            if (controller.loading.value && images.isEmpty) {
              return TLoaderAnimation();
            }

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: TSizes.spaceBtwItems / 2,
                    runSpacing: TSizes.spaceBtwItems / 2,
                    children: images
                        .map((image) => GestureDetector(
                              onTap: () => Get.dialog(ImagePopup(image: image)),
                              child: SizedBox(
                                width: 140,
                                height: 180,
                                child: Column(
                                  children: [
                                    allowSelection
                                        ? _buildListWithCheckbox(image)
                                        : _buildSimpleList(image),
                                    Expanded(
                                        child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: TSizes.sm),
                                      child: Text(
                                        image.fileName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ))
                        .toList()),

                // Load more Media Button -> Show when all images loaded
                if (!controller.loading.value)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreImages(),
                            label: Text("Load More"),
                            icon: Icon(Iconsax.arrow_down),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          }),
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
          width: 300,
          height: 300,
          text: "Select your desired folder",
          animation: TImages.packageAnimation,
          style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      imageType: ImageType.network,
      image: image.url,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }

  Widget _buildListWithCheckbox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          width: 140,
          height: 140,
          padding: TSizes.sm,
          imageType: ImageType.network,
          image: image.url,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),
        Positioned(
            top: TSizes.md,
            right: TSizes.md,
            child: Obx(() => Checkbox(
                value: image.isSelected.value,
                onChanged: (selected) {
                  if (selected != null) {
                    image.isSelected.value = selected;
                    if (selected) {
                      if (allowMultipleSelection) {
                        // If multiple section is not allowed, uncheck other checkboxes
                        for (var otherImage in selectedImages) {
                          if (otherImage != image) {
                            otherImage.isSelected.value = false;
                          }
                        }
                        selectedImages.clear();
                      }
                      selectedImages.add(image);
                    } else {
                      selectedImages.remove(image);
                    }
                  }
                })))
      ],
    );
  }

  Widget buildSelectedImagesButton() {
    return Row(
      children: [
        // CLose button
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
            onPressed: () => Get.back(),
            label: Text("Close"),
            icon: Icon(Iconsax.close_circle),
          ),
        ),
        SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: Text("Add"),
            icon: Icon(Iconsax.image),
          ),
        )
      ],
    );
  }
}
