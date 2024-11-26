import 'package:bouncy_bargain/features/authentication/screens/password_configuration/forget_password_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/signup_screen.dart';
import 'package:bouncy_bargain/navigation_menu.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XLoginForm extends StatelessWidget {
  const XLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: XSizes.spaceBtwSections),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: XTexts.email),
          ),
          const SizedBox(
            height: XSizes.spaceBtwInputFields,
          ),
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: XTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: XSizes.spaceBtwInputFields / 2,
          ),

          /// Remember Me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Remember Me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(XTexts.rememberMe)
                ],
              ),

              ///Forget Password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                  child: const Text(XTexts.forgetPassword))
            ],
          ),
          const SizedBox(
            height: XSizes.spaceBtwSections,
          ),

          // SignIn Button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()),
                  child: const Text(XTexts.signIn))),
          const SizedBox(
            height: XSizes.spaceBtwItems,
          ),

          // Create Account Button
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(XTexts.createAccount))),
        ],
      ),
    ));
  }
}
