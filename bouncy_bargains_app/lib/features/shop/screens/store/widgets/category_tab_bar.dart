import 'package:bouncy_bargain/common/widgets/brands/brands_show_case.dart';
import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class XCategoryTab extends StatelessWidget {
  const XCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              const XBrandsShowCase(
                images: [
                  XImages.productImage1,
                  XImages.productImage2,
                  XImages.productImage3,
                ],
              ),
              const XBrandsShowCase(
                images: [
                  XImages.productImage1,
                  XImages.productImage2,
                  XImages.productImage3,
                ],
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),

              // Products
              XSectionHeading(
                title: 'You might like',
                onPressed: () {},
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),

              XGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => const XProductCardVertical()),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
