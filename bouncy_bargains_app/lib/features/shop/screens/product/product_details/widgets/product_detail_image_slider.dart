import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:bouncy_bargain/common/widgets/icons/circular_icon.dart';
import 'package:bouncy_bargain/common/widgets/images/x_rounded_image.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XProductImageSlider extends StatelessWidget {
  const XProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return XCurvedEdgeWidget(
      child: Container(
        color: dark ? XColors.darkerGrey : XColors.light,
        child: Stack(
          children: [
            // Main large Image
            const SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(XSizes.productImageRadius * 2),
                  child: Center(
                      child: Image(image: AssetImage(XImages.productImage5))),
                )),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: XSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(
                          width: XSizes.spaceBtwItems,
                        ),
                    itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => XRoundedImage(
                          imageUrl: XImages.productImage3,
                          width: 80,
                          backgroundColor: dark ? XColors.dark : XColors.white,
                          border: Border.all(color: XColors.primary),
                          padding: const EdgeInsets.all(XSizes.sm),
                        )),
              ),
            ),

            // App bar icons
            const XAppBar(
              showBackArrow: true,
              actions: [
                XCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
