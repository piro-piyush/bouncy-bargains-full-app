import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return TRoundedContainer(
      padding: EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Obx(() {
                return TImageUploader(
                  imageType: controller.admin.value.profilePicture!=null
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.admin.value.profilePicture!=null
                      ? controller.admin.value.profilePicture
                      : TImages.user,
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  icon: Iconsax.camera,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateProfilePicture(),
                );
              }),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Obx(() {
                return Text(
                  controller.admin.value.fullName,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge,
                );
              }),
              Obx(() {
                return Text(controller.admin.value.email);
              }),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          )
        ],
      ),
    );
  }
}
