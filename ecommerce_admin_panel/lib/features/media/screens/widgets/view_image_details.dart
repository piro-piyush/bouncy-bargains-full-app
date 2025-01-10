import 'package:clipboard/clipboard.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopup extends StatelessWidget {
  // Constructor for image popup class
  const ImagePopup({super.key, required this.image});

  // The image model to display
  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: TRoundedContainer(
        // Set the width of the rounded container based on the screen size.
        width: TDeviceUtils.isDesktopScreen(context)
            ? MediaQuery.of(context).size.width * 0.4
            : double.infinity,
        padding: EdgeInsets.all(TSizes.spaceBtwItems),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image with an option to close the dialog.
            SizedBox(
              child: Stack(
                children: [
                  // Display the images with rounded container.
                  TRoundedContainer(
                    backgroundColor: TColors.primaryBackground,
                    child: TRoundedImage(
                      image: image.url,
                      applyImageRadius: true,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: TDeviceUtils.isDesktopScreen(context)
                          ? MediaQuery.of(context).size.width * 0.4
                          : double.infinity,
                      imageType: ImageType.network,
                    ),
                  ),

                  // Close icon button positioned at the right top corner.
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(Iconsax.close_circle)))
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            // Display various metadata about the image.
            // Include image name, path, type, size, creation, and modification dates, and Url.
            //   Also provides an option to copy the image Url.
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Image Name",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                Expanded(
                    flex: 3,
                    child: Text(
                      image.fileName,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              ],
            ),

            // Display the image Url with an option to copy it.
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Image URL",
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          FlutterClipboard.copy(image.url).then((value) =>
                              TLoaders.customToast(message: "URL copied"));
                        },
                        child: Text('Copy URL')))
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // Display a  button to delete the image.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextButton(
                      onPressed: () => MediaController.instance
                          .removeCloudImageConfirmation(image),
                      child: Text(
                        "Delete Image",
                        style: TextStyle(color: Colors.red),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
