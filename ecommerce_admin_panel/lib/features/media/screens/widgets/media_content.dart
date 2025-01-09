import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Folders Dropdown
          Row(
            children: [
              Text(
                "Select Folder",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              MediaFolderDropdown(
                onChanged: (MediaCategory? newValue) {
                  if (newValue != null) {
                    controller.selectedPath.value = newValue;
                  }
                },
              )
            ],
          ),

          // Upload & Remove Buttons
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Remove All",
                ),
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              TDeviceUtils.isMobileScreen(context)
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: TSizes.buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Upload",
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Show Media
          Wrap(
            alignment: WrapAlignment.start,
            spacing: TSizes.spaceBtwItems / 2,
            runSpacing: TSizes.spaceBtwItems / 2,
            children: [
              TRoundedImage(
                width: 90,
                height: 90,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.acerlogo,
                backgroundColor: TColors.primaryBackground,
              ),
              TRoundedImage(
                width: 90,
                height: 90,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.adidasLogo,
                backgroundColor: TColors.primaryBackground,
              ),
              TRoundedImage(
                width: 90,
                height: 90,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.adidasLogo,
                backgroundColor: TColors.primaryBackground,
              ),
              TRoundedImage(
                width: 90,
                height: 90,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.adidasLogo,
                backgroundColor: TColors.primaryBackground,
              ),
              TRoundedImage(
                width: 90,
                height: 90,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.adidasLogo,
                backgroundColor: TColors.primaryBackground,
              ),
            ],
          ),

          // Load more Media Button
          Padding(
            padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: TSizes.buttonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text("Load More"),
                    icon: Icon(Iconsax.arrow_down),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
