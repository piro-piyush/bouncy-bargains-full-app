import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XVerticalImageText extends StatelessWidget {
  const XVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = XColors.white,
    this.backgroundColor,
    this.onTapped,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.only(right: XSizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular Icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(XSizes.sm),
              decoration: BoxDecoration(
                  color:
                      backgroundColor ?? (dark ? XColors.black : XColors.white),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Image(
                  image: const AssetImage(XImages.shoeIcon),
                  fit: BoxFit.cover,
                  color: dark ? XColors.light : XColors.dark,
                ),
              ),
            ),

            // Text
            const SizedBox(
              height: XSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
