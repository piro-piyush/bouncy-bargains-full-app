import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductVariations extends StatelessWidget {
  ProductVariations({super.key});

  final controller = EditProductController.instance;

  @override
  Widget build(BuildContext context) {
    final variationController = controller.productVariationsController;
    return Obx(() => controller.productType.value == ProductType.variable
        ? TRoundedContainer(
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
                    TextButton(
                        onPressed: () => controller.productVariationsController
                            .removeVariation(context),
                        child: Text("Remove Variations"))
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                // Variations List
                if (variationController.productVariations.isNotEmpty)
                  ListView.separated(
                    itemCount: variationController.productVariations.length,
                    itemBuilder: (_, index) {
                      final variation =
                          variationController.productVariations[index];
                      return _buildVariationTile(
                          context, index, variation, variationController);
                    },
                    separatorBuilder: (_, __) => SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    shrinkWrap: true,
                  )
                else
                  _buildNoVariationsMessage(),
              ],
            ),
          )
        : SizedBox.shrink());
  }

  // Helper method to build variation tile
  Widget _buildVariationTile(
      BuildContext context,
      int index,
      ProductVariationModel variation,
      ProductVariationsController productVariationsController) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(TSizes.sm),
      title: Text(variation.attributeValues.entries
          .map((entry) => '${entry.key} : ${entry.value}')
          .join(', ')),
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      children: [
        // Upload Variations Image
        Obx(() => TImageUploader(
              imageType: variation.image.value.isNotEmpty
                  ? ImageType.network
                  : ImageType.asset,
              image: variation.image.value.isNotEmpty
                  ? variation.image.value
                  : TImages.defaultImage,
              onIconButtonPressed: () => controller.productImagesController
                  .selectVariationImage(variation),
              right: 0,
              left: null,
            )),
        SizedBox(
          height: TSizes.spaceBtwInputFields,
        ),

        // Variations Stock, and pricing
        Row(
          spacing: 8,
          children: [
            Expanded(
                child: TextFormField(
              onChanged: (value) => variation.stock = int.parse(value),
              keyboardType: TextInputType.number,
              controller: productVariationsController
                  .stockControllersList[index][variation],
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  labelText: "Stock",
                  hintText: "Add Stocks, only numbers are allowed"),
            )),
            Expanded(
                child: TextFormField(
              onChanged: (value) => variation.salePrice = double.parse(value),
              controller: productVariationsController
                  .salePriceControllersList[index][variation],
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
          onChanged: (value) => variation.description = value,
          controller: productVariationsController
              .descriptionControllersList[index][variation],
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
