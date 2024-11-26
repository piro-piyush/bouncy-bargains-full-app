import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/products/ratings/rating_indicator.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_reviews/widgets/user_review_card.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: const XAppBar(
        title: Text('Review & Ratings'),
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ratings and reviews are verified and are from people who use the same type of devices that you use.'),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),

              // Overall Product Ratings
              const XOverallProductRatings(),
              const XRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // User Reviews List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
