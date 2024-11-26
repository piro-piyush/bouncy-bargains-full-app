import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/device/device_utility.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XSearchContainer extends StatelessWidget {
  const XSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTapped,
    this.padding = const EdgeInsets.symmetric(horizontal: XSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTapped;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: padding,
        child: Container(
          width: XDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(XSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? XColors.dark
                      : XColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(XSizes.cardRadiusLg),
              border: showBorder ? Border.all(color: XColors.grey) : null),
          child: Row(
            children: [
              Icon(
                icon,
                color: dark ? XColors.darkerGrey : XColors.grey,
              ),
              const SizedBox(
                width: XSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
