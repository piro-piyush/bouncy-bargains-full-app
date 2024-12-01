import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_price_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_title_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/x_brand_title_text_with_verified_icon.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/enums.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XProductMetaData extends StatelessWidget {
  const XProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale Price
        Row(
          children: [
            // Sale Tag
            XRoundedContainer(
              radius: XSizes.sm,
              backgroundColor: XColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: XSizes.sm, vertical: XSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: XColors.black),
              ),
            ),
            const SizedBox(
              width: XSizes.spaceBtwItems,
            ),

            // Price
            Text(
              '\$250',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: XSizes.spaceBtwItems,
            ),
            const XProductPriceText(
              price: '175',
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems / 1.5,
        ),

        // Title
        const XProductTitleText(
          title: 'Green Nike Sports Shirt',
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems / 1.5,
        ),

        // Stock Status
        Row(
          children: [
            const XProductTitleText(
              title: 'Status',
            ),
            const SizedBox(
              width: XSizes.spaceBtwItems,
            ),
            Text('In Stock', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems / 1.5,
        ),

        // Brand
        Row(
          children: [
            XCircularImage(
                width: 32,
                height: 32,
                overlayColor: dark ? XColors.white : XColors.black,
                image: XImages.shoeIcon),
            const XBrandTitleWithVerifiedIcon(
              title: "Nike",
              brandTextSize: TexXSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
