import 'package:bouncy_bargain/common/widgets/login_signup/form_divider.dart';
import 'package:bouncy_bargain/common/widgets/login_signup/social_buttons.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                XTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              /// Form
              const XSignupForm(),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              /// Divider
              XFormDivider(
                dividerText: XTexts.orSignUpWith.capitalize!,
              ),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Social Buttons
              const XSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
