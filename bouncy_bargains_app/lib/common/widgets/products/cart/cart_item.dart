import 'package:bouncy_bargain/common/widgets/images/x_rounded_image.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_title_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/x_brand_title_text_with_verified_icon.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XCartItem extends StatelessWidget {
  const XCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        // Image
        XRoundedImage(
          imageUrl: XImages.productImage1,
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(XSizes.sm),
          backgroundColor: dark ? XColors.darkerGrey : XColors.light,
        ),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),

        // Title, Price & Size
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const XBrandTitleWithVerifiedIcon(title: 'Nike'),
            const Flexible(
              child: XProductTitleText(
                title: 'Black Sports Shoes',
                maxLines: 1,
              ),
            ),

            // Attributes
            Text.rich(TextSpan(children: [
              TextSpan(text: "Color ", style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: "Green ", style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: "Size ", style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: "UK 08 ", style: Theme.of(context).textTheme.bodySmall),
            ]))
          ],
        )
      ],
    );
  }
}
