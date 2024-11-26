import 'package:bouncy_bargain/common/styles/shadows.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/icons/circular_icon.dart';
import 'package:bouncy_bargain/common/widgets/images/x_rounded_image.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_price_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_title_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/x_brand_title_text_with_verified_icon.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/product_details_screen.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XProductCardVertical extends StatelessWidget {
  const XProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailsScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [XShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(XSizes.productImageRadius),
            color: dark ? XColors.darkerGrey : XColors.white),
        child: Column(
          children: [
            // Thumbnail, WishList Button, Discount Tag
            XRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(XSizes.sm),
              backgroundColor: dark ? XColors.dark : XColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  const XRoundedImage(
                    imageUrl: XImages.productImage1,
                    applyImageRadius: true,
                  ),

                  // Sale Tag
                  Positioned(
                    top: 12,
                    child: XRoundedContainer(
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
                  ),

                  // Favourite Icon
                  const Positioned(
                      top: 0,
                      right: 0,
                      child: XCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems / 2,
            ),

            // Details
            const Padding(
              padding: EdgeInsets.only(left: XSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  XProductTitleText(
                    title: 'Green Nike Air Shoes',
                    smallSize: true,
                  ),
                  SizedBox(
                    height: XSizes.spaceBtwItems / 2,
                  ),
                  XBrandTitleWithVerifiedIcon(
                    title: 'Nike',
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                const Padding(
                  padding: EdgeInsets.only(left: XSizes.sm),
                  child: XProductPriceText(
                    price: '35.0',
                  ),
                ),

                // Add to Cart Button
                Container(
                  decoration: const BoxDecoration(
                      color: XColors.dark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(XSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(XSizes.productImageRadius))),
                  child: const SizedBox(
                      width: XSizes.iconLg * 1.2,
                      height: XSizes.iconLg * 1.2,
                      child: Center(
                        child: Icon(
                          Iconsax.add,
                          color: XColors.white,
                        ),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
