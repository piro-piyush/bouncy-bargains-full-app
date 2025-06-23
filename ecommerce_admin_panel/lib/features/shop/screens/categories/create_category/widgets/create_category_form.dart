import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/create_category_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createCategoryController = CreateCategoryController.instance;
    final categoryController = createCategoryController.categoryController;
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: createCategoryController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              SizedBox(
                height: TSizes.sm,
              ),
              Text(
                "Create New Category",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.sm,
              ),

              // Name Text Field
              TextFormField(
                controller: createCategoryController.name,
                validator: (value) =>
                    TValidator.validateEmptyText("Name", value),
                decoration: InputDecoration(
                    labelText: "Category Name",
                    prefixIcon: Icon(Iconsax.category)),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Categories Dropdown
              Obx(() => categoryController.isLoading.value
                  ? TShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField(
                      decoration: InputDecoration(
                          hintText: "Parent Category",
                          labelText: "Parent Category",
                          prefixIcon: Icon(Iconsax.bezier)),
                      onChanged: (newValue) => createCategoryController
                          .selectedParent.value = newValue!,
                      items: categoryController.allItems
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [Text(item.name)],
                                ),
                              ))
                          .toList())),
              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              Obx(
                () => TImageUploader(
                  width: 80,
                  height: 80,
                  image: createCategoryController.imageUrl.value.isNotEmpty
                      ? createCategoryController.imageUrl.value
                      : TImages.defaultImage,
                  imageType: createCategoryController.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () =>
                      createCategoryController.pickImage(),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                () => CheckboxMenuButton(
                    value: createCategoryController.isFeatured.value,
                    onChanged: (value) => createCategoryController
                        .isFeatured.value = value ?? false,
                    child: Text("Featured")),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => createCategoryController.createCategory(),
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
