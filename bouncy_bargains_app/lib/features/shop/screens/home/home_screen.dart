import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/shop/screens/all_products/all_products_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:bouncy_bargain/features/shop/screens/home/widgets/home_categories.dart';
import 'package:bouncy_bargain/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Bar
            const XPrimaryHeaderContainer(
              child: Column(
                children: [
                  // App Bar
                  XHomeAppBar(),
                  SizedBox(
                    height: XSizes.spaceBtwSections,
                  ),

                  // Search Bar
                  XSearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(
                    height: XSizes.spaceBtwSections,
                  ),

                  // Categories
                  Padding(
                    padding: EdgeInsets.only(left: XSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        XSectionHeading(
                          title: 'Popular Categories',
                          textColor: XColors.white,
                          showActionButton: false,
                        ),
                        SizedBox(
                          height: XSizes.spaceBtwItems,
                        ),

                        // List of Categories
                        XHomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: XSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            // Body
            Padding(
                padding: const EdgeInsets.all(XSizes.defaultSpace),
                child: Column(
                  children: [
                    // Promo slider
                    const XPromoSlider(
                      banners: [XImages.promoBanner1, XImages.promoBanner2, XImages.promoBanner3, XImages.promoBanner3],
                    ),
                    const SizedBox(
                      height: XSizes.spaceBtwSections,
                    ),

                    // Heading
                    XSectionHeading(
                      title: 'Popular Products',
                      onPressed: () {
                        Get.to(() => const AllProductsScreen());
                      },
                    ),
                    const SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),

                    // Popular products
                    XGridLayout(
                      itemBuilder: (_, index) => const XProductCardVertical(),
                      itemCount: 2,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
