import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, index) => const SizedBox(
              height: XSizes.spaceBtwItems,
            ),
        itemCount: 12,
        itemBuilder: (_, index) => XRoundedContainer(
              showBorder: true,
              backgroundColor: dark ? XColors.dark : XColors.light,
              padding: const EdgeInsets.all(XSizes.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row - 1
                  Row(
                    children: [
                      // 1 - Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(
                        width: XSizes.spaceBtwItems / 2,
                      ),

                      // 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Processing", style: Theme.of(context).textTheme.bodyLarge!.apply(color: XColors.primary, fontWeightDelta: 1)),
                            Text("07 Nov 2022", style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),

                      // 3 - Icon
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: XSizes.iconSm,
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  // Row - 2
                  Row(
                    children: [
                      // Row - 1
                      Expanded(
                        child: Row(
                          children: [
                            // 1 - Icon
                            const Icon(Iconsax.ship),
                            const SizedBox(
                              width: XSizes.spaceBtwItems / 2,
                            ),

                            // 2 - Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order", style: Theme.of(context).textTheme.labelMedium),
                                  Text("#45454", style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Row - 2
                      Expanded(
                        child: Row(
                          children: [
                            // 1 - Icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(
                              width: XSizes.spaceBtwItems / 2,
                            ),

                            // 2 - Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Shipping Date", style: Theme.of(context).textTheme.labelMedium),
                                  Text("03 Feb 2033", style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}
