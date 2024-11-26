import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class XBillingAddressSection extends StatelessWidget {
  const XBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Text(
          'Piyush',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: XSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.phone,
              color: XColors.grey,
              size: 16,
            ),
            const SizedBox(height: XSizes.spaceBtwItems),
            Text(
              '+91-989-998-4433',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        const SizedBox(height: XSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(
              Icons.location_history,
              color: XColors.grey,
              size: 16,
            ),
            const SizedBox(height: XSizes.spaceBtwItems),
            Expanded(
                child: Text(
              'South Liana, Maine 8787',
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ))
          ],
        ),
      ],
    );
  }
}
