import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    final categoryController = Get.put(CategoryController());
    editController.init(category);
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
          key: editController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              SizedBox(
                height: TSizes.sm,
              ),
              Text(
                "Update Category",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: TSizes.sm,
              ),

              // Name Text Field
              TextFormField(
                controller: editController.name,
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
                      value: editController.selectedParent.value.id.isNotEmpty
                          ? editController.selectedParent.value
                          : null,
                      onChanged: (newValue) =>
                          editController.selectedParent.value = newValue!,
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
                  image: editController.imageUrl.value.isNotEmpty
                      ? editController.imageUrl.value
                      : TImages.defaultImage,
                  imageType: editController.imageUrl.value.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  onIconButtonPressed: () => editController.pickImage(),
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              Obx(
                () => CheckboxMenuButton(
                    value: editController.isFeatured.value,
                    onChanged: (value) =>
                        editController.isFeatured.value = value ?? false,
                    child: Text("Featured")),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => editController.updateCategory(category),
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
