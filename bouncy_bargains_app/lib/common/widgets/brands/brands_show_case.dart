import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/brands/brand_card.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XBrandsShowCase extends StatelessWidget {
  const XBrandsShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return XRoundedContainer(
      showBorder: true,
      borderColor: XColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(XSizes.md),
      margin: const EdgeInsets.only(bottom: XSizes.spaceBtwItems),
      child: Column(
        children: [
          // Brand with Products Count
          const XBrandCard(showBorder: false),
          const SizedBox(height: XSizes.spaceBtwItems,),
          // Brand Top 3 Product Images
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Expanded(
      child: XRoundedContainer(
        height: 100,
        backgroundColor: dark ? XColors.darkerGrey : XColors.light,
        margin: const EdgeInsets.only(right: XSizes.sm),
        padding: const EdgeInsets.all(XSizes.md),
        child: Image(fit: BoxFit.contain, image: AssetImage(image)),
      ),
    );
  }
}
