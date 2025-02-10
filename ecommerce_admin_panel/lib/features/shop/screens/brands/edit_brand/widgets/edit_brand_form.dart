import 'package:ecommerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);
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
                "Edit Brand",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Name Text Field
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    TValidator.validateEmptyText("Name", value),
                decoration: InputDecoration(
                    labelText: "Brand Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),

              // Categories
              Text(
                'Select Categories',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),
              Obx(() =>
                  Wrap(
                    spacing: TSizes.sm,
                    children: CategoryController.instance.allItems
                        .map(
                          (category) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: TSizes.sm),
                            child: TChoiceChip(
                              text: category.name,
                              selected: controller.selectedCategories
                                  .contains(category),
                              onSelected: (value) =>
                                  controller.toggleSelection(category),
                            ),
                          ),
                    )
                        .toList(),
                  )),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              // Image Uploader
              Obx(() {
                return TImageUploader(
                  width: 80,
                  height: 80,
                  image: controller.imageUrl.value.isNotEmpty
                      ? controller.imageUrl.value
                      : TImages.defaultImage,
                  imageType: controller.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () => controller.pickImage(),
                );
              }),
              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // CheckBox
              Obx(() {
                return CheckboxMenuButton(
                    value: controller.isFeatured.value,
                    onChanged: (value) =>
                    controller.isFeatured.value = value ?? false,
                    child: Text("Featured"));
              }),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.updateBrand(brand),
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
