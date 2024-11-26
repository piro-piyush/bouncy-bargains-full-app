import 'package:bouncy_bargain/common/widgets/icons/circular_icon.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XBottomAddToCart extends StatelessWidget {
  const XBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: XSizes.defaultSpace,
        vertical: XSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(color: dark ? XColors.darkerGrey : XColors.light, borderRadius: const BorderRadius.only(topLeft: Radius.circular(XSizes.cardRadiusLg), topRight: Radius.circular(XSizes.cardRadiusLg))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const XCircularIcon(
                icon: Iconsax.minus,
                width: 40,
                height: 40,
                backgroundColor: XColors.darkGrey,
                color: XColors.white,
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
                width: 40,
                height: 40,
                backgroundColor: XColors.black,
                color: XColors.white,
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(XSizes.md), backgroundColor: XColors.black, side: const BorderSide(color: XColors.black)), child: const Text('Add to Cart'))
        ],
      ),
    );
  }
}
