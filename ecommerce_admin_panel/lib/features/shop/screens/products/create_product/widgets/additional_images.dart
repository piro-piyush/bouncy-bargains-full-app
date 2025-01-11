import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages(
      {super.key,
      required this.additionalProductImageURLs,
      this.onTapToAddImages,
      this.onTapToRemoveImages});

  final RxList<String> additionalProductImageURLs;
  final Function()? onTapToAddImages;
  final Function(int index)? onTapToRemoveImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: Column(
          children: [
            // Section to Add Additional Product Images
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: onTapToAddImages,
                  child: TRoundedContainer(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            TImages.defaultMultiImageIcon,
                            width: 50,
                            height: 50,
                          ),
                          Text("Add Additional Product Images")
                        ],
                      ),
                    ),
                  ),
                )),

            Expanded(
                child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 80,
                      child: _uploadedImagesOrEmptyList(),
                    )),

                // Add More Images Button
                TRoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: TColors.grey,
                  backgroundColor: TColors.white,
                  onTap: onTapToAddImages,
                  child: Center(
                    child: Icon(Iconsax.add),
                  ),
                )
              ],
            ))
          ],
        ));
  }

  // Widget to Display Either Upload images or Empty list
  Widget _uploadedImagesOrEmptyList() {
    return additionalProductImageURLs.isNotEmpty
        ? _uploadedImages()
        : emptyList();
  }

  // Widget to Display empty List placeholder
  Widget emptyList() {
    return ListView.separated(
        itemBuilder: (context, index) => TRoundedContainer(
            backgroundColor: TColors.primaryBackground, width: 80, height: 80),
        separatorBuilder: (context, index) => SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
        itemCount: 6,
        scrollDirection: Axis.horizontal);
  }

  // Widget to Display uploaded images
  ListView _uploadedImages() {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
        itemCount: additionalProductImageURLs.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final image = additionalProductImageURLs[index];
          return TImageUploader(
            width: 80,
            height: 80,
            imageType: ImageType.network,
            onIconButtonPressed: () => onTapToRemoveImages!(index),
            top: 0,
            right: 0,
            left: null,
            bottom: null,
            icon: Iconsax.trash,
            image: image,
          );
        });
  }
}
