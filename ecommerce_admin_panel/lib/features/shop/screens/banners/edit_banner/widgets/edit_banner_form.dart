import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/edit_banner_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/routes/app_screens.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              SizedBox(
                height: TSizes.sm,
              ),
              Text(
                "Update Banner",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Column(
                children: [
                  Obx(() => GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: TRoundedImage(
                          width: 400,
                          height: 200,
                          backgroundColor: TColors.primaryBackground,
                          image: controller.imageUrl.isNotEmpty
                              ? controller.imageUrl.value
                              : TImages.defaultImage,
                          imageType: controller.imageUrl.isNotEmpty
                              ? ImageType.network
                              : ImageType.asset,
                        ),
                      )),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextButton(
                      onPressed: () => controller.pickImage(),
                      child: Text('Select Image'))
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              Text(
                'Make your banner Active or Inactive',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              Obx(
                () => CheckboxMenuButton(
                  value: controller.isActive.value,
                  onChanged: (value) =>
                      controller.isActive.value = value ?? false,
                  child: Text("Active"),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Dropdown Menu Screen
              Obx(() {
                return DropdownButton<String>(
                    value: controller.targetScreen.value,
                    onChanged: (String? newValue) =>
                        controller.targetScreen.value = newValue!,
                    items: AppScreens.allAppScreenItems
                        .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                        .toList());
              }),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              // Create Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateBanner(banner),
                    child: Text("Update")),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
