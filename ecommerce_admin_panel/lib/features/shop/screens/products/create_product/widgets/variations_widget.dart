import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Variation Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Variations",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(onPressed: () {}, child: Text("Remove Variations"))
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // Variations List
          ListView.separated(
            itemBuilder: (_, index) {
              return _buildVariationTile();
            },
            separatorBuilder: (_, __) => SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemCount: 2,
            shrinkWrap: true,
          ),

          // No Variation Message
          _buildNoVariationsMessage(),
        ],
      ),
    );
  }

  // Helper method to build variation tile
  Widget _buildVariationTile() {
    return ExpansionTile(
      title: Text("Color : Green"),
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      children: [
        // Upload Variations Image
        Obx(() => TImageUploader(
              imageType: ImageType.asset,
              image: TImages.defaultImage,
              onIconButtonPressed: () {},
              right: 0,
              left: null,
            )),
        SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        // Variations Stock, and pricing
        Row(
          children: [
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  labelText: "Stock",
                  hintText: "Add Stocks, only numbers are allowed"),
            )),
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
              ],
              decoration: InputDecoration(
                  labelText: "Discounted Price",
                  hintText: "Price with up-to 2 decimals"),
            ))
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Variation Description
        TextFormField(
          decoration: InputDecoration(
              labelText: "Description",
              hintText: "Add description to this variation..."),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        )
      ],
    );
  }

  Widget _buildNoVariationsMessage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              imageType: ImageType.asset,
              image: TImages.defaultVariationImageIcon,
              width: 200,
              height: 200,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text("There are no Variations  added for this product")
      ],
    );
  }
}
