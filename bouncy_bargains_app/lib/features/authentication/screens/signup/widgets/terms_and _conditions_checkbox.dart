import 'package:bouncy_bargain/features/authentication/controllers/signup/signup_controller.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class XTermsAndConditions extends StatelessWidget {
  const XTermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = XHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                  value: controller.privacyPolicy.value,
                  onChanged: (value) => controller.privacyPolicy.value =
                      !controller.privacyPolicy.value,
                ))),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${XTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${XTexts.privacyPolicy} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? XColors.white : XColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? XColors.white : XColors.primary,
                  )),
          TextSpan(
              text: '${XTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${XTexts.termsOfUse} ',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? XColors.white : XColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? XColors.white : XColors.primary,
                  )),
        ]))
      ],
    );
  }
}
