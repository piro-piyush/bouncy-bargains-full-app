import 'package:bouncy_bargain/common/widgets/icons/circular_icon.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XProductQuantityWithAddOrRemoveButton extends StatelessWidget {
  const XProductQuantityWithAddOrRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        XCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: XSizes.md,
          color: dark ? XColors.white : XColors.black,
          backgroundColor: dark ? XColors.darkerGrey : XColors.light,
        ),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),
        Text(
          '2',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),
        const XCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: XSizes.md,
          color: XColors.white,
          backgroundColor: XColors.primary,
        ),
      ],
    );
  }
}
