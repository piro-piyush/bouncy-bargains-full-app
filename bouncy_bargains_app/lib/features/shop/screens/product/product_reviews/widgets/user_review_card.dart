import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/products/ratings/rating_indicator.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(XImages.userProfileImage1),
                ),
                const SizedBox(
                  width: XSizes.spaceBtwItems,
                ),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems,
        ),

        // Reviews
        Row(
          children: [
            const XRatingBarIndicator(rating: 4),
            const SizedBox(
              width: XSizes.spaceBtwItems,
            ),
            Text(
              '01 Nov 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),

        const ReadMoreText(
          'The user interference of the app is quite intuitive. I was able to navigate and make purchase seamlessly. Great job!',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: XColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: XColors.primary),
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems,
        ),

        // Company Review
        XRoundedContainer(
          backgroundColor: dark ? XColors.darkerGrey : XColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(XSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bouncy Bargains', style: Theme.of(context).textTheme.titleMedium),
                    Text('02 Nov 2023', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(
                  width: XSizes.spaceBtwItems,
                ),
                const ReadMoreText(
                  'Thank you ! For your valuable review',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: XColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: XColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: XSizes.spaceBtwSections,
        )
      ],
    );
  }
}
