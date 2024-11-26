import 'package:bouncy_bargain/features/authentication/screens/signup/widgets/terms_and%20_conditions_checkbox.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XSignupForm extends StatelessWidget {
  const XSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                // expands:false,
                decoration: const InputDecoration(
                    labelText: XTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(
              width: XSizes.spaceBtwInputFields,
            ),
            Expanded(
              child: TextFormField(
                // expands:false,
                decoration: const InputDecoration(
                    labelText: XTexts.lastName, prefixIcon: Icon(Iconsax.user)),
              ),
            )
          ],
        ),
        const SizedBox(
          height: XSizes.spaceBtwSections,
        ),

        // Username
        TextFormField(
          // expands:false,
          decoration: const InputDecoration(
              labelText: XTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
        ),
        const SizedBox(
          height: XSizes.spaceBtwInputFields,
        ),

        // Email
        TextFormField(
          // expands:false,
          decoration: const InputDecoration(
              labelText: XTexts.email, prefixIcon: Icon(Iconsax.direct)),
        ),
        const SizedBox(
          height: XSizes.spaceBtwInputFields,
        ),

        // Phone Number
        TextFormField(
          // expands:false,
          decoration: const InputDecoration(
              labelText: XTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
        ),
        const SizedBox(
          height: XSizes.spaceBtwInputFields,
        ),

        // Password
        TextFormField(
          // expands:false,
          decoration: const InputDecoration(
            labelText: XTexts.password,
            prefixIcon: Icon(Iconsax.password_check),
            suffixIcon: Icon(Iconsax.eye_slash),
          ),
        ),
        const SizedBox(
          height: XSizes.spaceBtwSections,
        ),

        /// Terms&Conditions CheckBox
        const XTermsAndConditions(),
        const SizedBox(
          height: XSizes.spaceBtwSections,
        ),

        /// Signup Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.to(() => const VerifyEmailScreen()),
              child: const Text(XTexts.createAccount)),
        )
      ],
    ));
  }
}
