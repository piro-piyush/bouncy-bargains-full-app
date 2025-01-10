import 'package:ecommerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

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
            "Create New Banner",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Name Text Field
          TextFormField(
            // validator: (value) => TValidator.validateEmptyText("Name", value),
            decoration: InputDecoration(
                labelText: "Banner Name", prefixIcon: Icon(Iconsax.category)),
          ),

          // Categories
          Text(
            'Select Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields / 2,
          ),
          Wrap(
            spacing: TSizes.sm,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: TSizes.sm),
                child: TChoiceChip(
                  text: "Shoes",
                  selected: true,
                  onSelected: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: TSizes.sm),
                child: TChoiceChip(
                  text: "Track Suites",
                  selected: false,
                  onSelected: (value) {},
                ),
              )
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          // Image Uploader
          TImageUploader(
            width: 80,
            height: 80,
            image: TImages.defaultImage,
            imageType: ImageType.asset,
            onIconButtonPressed: () {},
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // CheckBox
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
