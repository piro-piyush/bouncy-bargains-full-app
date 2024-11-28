import 'package:bouncy_bargain/common/styles/spacing_styles.dart';
import 'package:bouncy_bargain/common/widgets/login_signup/form_divider.dart';
import 'package:bouncy_bargain/common/widgets/login_signup/social_buttons.dart';
import 'package:bouncy_bargain/features/authentication/screens/login/widgets/login_form.dart';
import 'package:bouncy_bargain/features/authentication/screens/login/widgets/login_header.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: XSpacingStyles.paddingWithAppBarHeight,
        child: Column(
          children: [
            /// Logo, Title & Sub-Title
            XLoginHeader(dark: dark),

            /// Form
            const XLoginForm(),

            /// Divider
            XFormDivider(
              dividerText: XTexts.orSignInWith.capitalize!,
            ),
            const SizedBox(
              height: XSizes.spaceBtwSections,
            ),

            /// Footer
            const XSocialButtons()
          ],
        ),
      )),
    );
  }
}
