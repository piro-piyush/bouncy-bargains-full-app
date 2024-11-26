import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XSingleAddress extends StatelessWidget {
  const XSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return XRoundedContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(XSizes.md),
      showBorder: true,
      backgroundColor: selectedAddress ? XColors.primary.withOpacity(0.5) : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? XColors.darkerGrey
              : XColors.grey,
      margin: const EdgeInsets.only(bottom: XSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 5,
            child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
                color: selectedAddress
                    ? dark
                        ? XColors.light
                        : XColors.dark
                    : null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: XSizes.sm / 2,
              ),
              const Text(
                '(+91) 893 983 3299',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: XSizes.sm / 2,
              ),
              const Text(
                '322 Timmy Coves, South Liana, Maine, 78798, USA',
                softWrap: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
