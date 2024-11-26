import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XBillingPaymentSection extends StatelessWidget {
  const XBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        XSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        const SizedBox(
          height: XSizes.spaceBtwItems / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            XRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? XColors.light : XColors.white,
              padding: const EdgeInsets.all(XSizes.sm),
              child: const Image(
                image: AssetImage(XImages.paypal),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems / 2,
            ),
            Text(
              'Paypal',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        )
      ],
    );
  }
}
