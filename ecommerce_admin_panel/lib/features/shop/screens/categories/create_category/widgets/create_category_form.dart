import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
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
            validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: InputDecoration(
                labelText: "Category Name", prefixIcon: Icon(Iconsax.category)),
          ),SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          DropdownButtonFormField(
              decoration: InputDecoration(
                  hintText: "Parent Category",
                  labelText: "Parent Category",
                  prefixIcon: Icon(Iconsax.bezier)),
              items: [
                DropdownMenuItem(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text("item.name")],
                ))
              ],
              onChanged: (newValue) {}),
          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
          TImageUploader(
            width: 80,
            height: 80,
            image: TImages.defaultImage,
            imageType: ImageType.asset,
            onIconButtonPressed: () {},
          ),

          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          CheckboxMenuButton(
              value: true, onChanged: (value) {}, child: Text("Featured")),

          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text("Create")),
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
        ],
      )),
    );
  }
}
