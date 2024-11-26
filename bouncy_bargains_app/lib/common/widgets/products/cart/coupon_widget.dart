import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XCouponCode extends StatelessWidget {
  const XCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return XRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? XColors.dark : XColors.white,
      padding: const EdgeInsets.only(top: XSizes.sm, bottom: XSizes.sm, right: XSizes.sm, left: XSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Have a promo code? Enter here",
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          // Button
          SizedBox(
              width: 80,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(foregroundColor: dark ? XColors.white.withOpacity(0.5) : XColors.dark.withOpacity(0.5), backgroundColor: XColors.grey.withOpacity(0.2), side: BorderSide(color: XColors.grey.withOpacity(0.1))),
                  onPressed: () {},
                  child: const Text("Apply")))
        ],
      ),
    );
  }
}
