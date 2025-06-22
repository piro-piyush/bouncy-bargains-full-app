import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Obx(() {
                return TImageUploader(
                  imageType: controller.settings.value.appLogo.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.settings.value.appLogo.isNotEmpty
                      ? controller.settings.value.appLogo
                      : TImages.defaultImage,
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: controller.updateAppLogo,
                );
              }),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(() {
                return Text(
                  controller.settings.value.appName,
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              }),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // Text("piyush72717272@gmail.com"),
              // SizedBox(
              //   height: TSizes.spaceBtwItems,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
