import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class XCategoryShimmer extends StatelessWidget {
  const XCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(
                width: XSizes.spaceBtwItems,
              ),
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Images
                XShimmerEffect(
                  width: 55,
                  height: 55,
                  radius: 55,
                ),
                SizedBox(
                  height: XSizes.spaceBtwItems / 2,
                ),

                // Text
                XShimmerEffect(width: 55, height: 8),
              ],
            );
          }),
    );
  }
}
