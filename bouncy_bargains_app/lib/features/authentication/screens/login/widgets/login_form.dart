import 'package:bouncy_bargain/features/authentication/controllers/login/login_controller.dart';
import 'package:bouncy_bargain/features/authentication/screens/password_configuration/forget_password_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/signup_screen.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XLoginForm extends StatelessWidget {
  const XLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: XSizes.spaceBtwSections),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: controller.email,
                validator: (value) => XValidator.validateEmail(value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: XTexts.email),
              ),
              const SizedBox(
                height: XSizes.spaceBtwInputFields,
              ),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) =>
                      XValidator.validateEmptyText("Password", value),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: XTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: controller.hidePassword.value
                              ? const Icon(Iconsax.eye_slash)
                              : const Icon(Iconsax.eye))),
                ),
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
                      Obx(
                        () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value =
                                !controller.rememberMe.value),
                      ),
                      const Text(XTexts.rememberMe)
                    ],
                  ),

                  ///Forget Password
                  TextButton(
                      onPressed: () =>
                          Get.to(() => const ForgetPasswordScreen()),
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
                      onPressed: () => controller.emailAndPasswordSignIn(),
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
