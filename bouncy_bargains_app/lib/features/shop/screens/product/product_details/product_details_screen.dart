import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/widgets/product_attributes.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/widgets/product_detail_image_slider.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/widgets/product_meta_data.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/widgets/rating_share_widget.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_reviews/product_reviews_screen.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1 Product image slider
            const XProductImageSlider(),

            // 2 Product details
            Padding(
                padding: const EdgeInsets.only(right: XSizes.defaultSpace, left: XSizes.defaultSpace, bottom: XSizes.defaultSpace),
                child: Column(
                  children: [
                    // Rating & Share
                    const XRatingAndShare(),

                    // Price, title, stock & brand
                    const XProductMetaData(),

                    // Attributes
                    const XProductAttributes(),
                    const SizedBox(
                      height: XSizes.spaceBtwSections,
                    ),

                    // Checkout  Button
                    SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text("Checkout"))),
                    const SizedBox(
                      height: XSizes.spaceBtwSections,
                    ),

                    // Description
                    const XSectionHeading(
                      title: "Description",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),
                    const ReadMoreText(
                      "This is a product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing for nothing else",
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "read more",
                      trimExpandedText: "show less",
                      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    ),

                    // Reviews
                    const Divider(),
                    const SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const XSectionHeading(
                          title: "Reviews(199)",
                          showActionButton: false,
                        ),
                        IconButton(
                            onPressed: () => Get.to(() => const ProductReviewsScreen()),
                            icon: const Icon(
                              Iconsax.arrow_right_3,
                              size: 18,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: XSizes.spaceBtwSections,
                    ),
                  ],
                ))
          ],
        ),
      ),
      bottomNavigationBar: const XBottomAddToCart(),
    );
  }
}
