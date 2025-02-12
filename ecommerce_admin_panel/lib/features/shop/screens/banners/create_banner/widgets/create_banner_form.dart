import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:ecommerce_admin_panel/routes/app_screens.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBannerController());
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
                "Create New Banner",
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
                    onPressed: () => controller.createBanner(),
                    child: Text("Create")),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
            ],
          )),
    );
  }
}
