import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductForm extends StatelessWidget {
  const EditProductForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
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
            "Update Banner",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          Column(
            children: [
              GestureDetector(
                child: TRoundedImage(
                  imageType: ImageType.asset,
                  width: 400,
                  height: 200,
                  backgroundColor: TColors.primaryBackground,
                  image: TImages.defaultImage,
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TextButton(onPressed: () {}, child: Text('Select Image'))
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          Text(
            'Make your banner Active or Inactive',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          CheckboxMenuButton(
            value: true,
            onChanged: (value) {},
            child: Text("Active"),
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // Dropdown Menu Screen
          DropdownButton<String>(
            value: 'search',
            onChanged: (String? newValue) {},
            items: [
              DropdownMenuItem(value: "home", child: Text("Home")),
              DropdownMenuItem(value: "search", child: Text("Search"))
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),

          // Create Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text("Update")),
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields * 2,
          ),
        ],
      )),
    );
  }
}
