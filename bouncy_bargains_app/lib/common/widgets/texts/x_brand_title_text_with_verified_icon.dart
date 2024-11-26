import 'package:bouncy_bargain/common/widgets/texts/x_brand_title_text.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/enums.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XBrandTitleWithVerifiedIcon extends StatelessWidget {
  const XBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = XColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: XBrandTitleText(
              title: title,
              maxLines: maxLines,
              color: textColor,
              textAlign: textAlign,
              brandTextSize: brandTextSize),
        ),
        const SizedBox(
          width: XSizes.sm,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: XSizes.iconXs,
        )
      ],
    );
  }
}
