import 'package:bouncy_bargain/common/widgets/chips/choice_chip.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_price_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/product_title_text.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XProductAttributes extends StatelessWidget {
  const XProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Selected Attribute pricing & description
        XRoundedContainer(
          padding: const EdgeInsets.all(XSizes.md),
          backgroundColor: dark ? XColors.darkerGrey : XColors.grey,
          child: Column(
            children: [
              // Title, Price and Stock Status
              Row(
                children: [
                  const XSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: XSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const XProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),

                          // Actual price
                          Text(
                            "\$25",
                            style: Theme.of(context).textTheme.bodyLarge!.apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: XSizes.spaceBtwItems,
                          ),

                          // Sale price
                          const XProductPriceText(price: '20'),
                        ],
                      ),
                      // Stock
                      Row(
                        children: [
                          const XProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            "In Stock",
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),

              // Variation
              const XProductTitleText(
                title: 'This is the description of the product and it can go upto max 4 lines',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems,
        ),

        // Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const XSectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems / 2,
            ),
            Wrap(spacing: 8, children: [
              XChoiceChip(
                text: "Green",
                selected: true,
                onSelected: (value) {},
              ),
              XChoiceChip(
                text: "Blue",
                selected: false,
                onSelected: (value) {},
              ),
              XChoiceChip(
                text: "Yellow",
                selected: false,
                onSelected: (value) {},
              ),
            ])
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const XSectionHeading(
              title: 'Size',
              showActionButton: false,
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                XChoiceChip(
                  text: "EU 34",
                  selected: true,
                  onSelected: (value) {},
                ),
                XChoiceChip(
                  text: "EU 36",
                  selected: false,
                  onSelected: (value) {},
                ),
                XChoiceChip(
                  text: "EU 38",
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
