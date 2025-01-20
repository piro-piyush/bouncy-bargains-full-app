import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
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
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
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
            XCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: XSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? XColors.light : XColors.dark,
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
