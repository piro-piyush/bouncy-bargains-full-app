import 'package:ecommerce_admin_panel/features/authentication/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              // Email
              TextFormField(
                controller: controller.loginEmail,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email,
                ),
              ),

              SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),

              // Password
              Obx(
                () => TextFormField(
                  controller: controller.loginPassword,
                  obscureText: controller.hideLoginPassword.value,
                  validator: (value) =>
                      TValidator.validateEmptyText("Password", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hideLoginPassword.value =
                                !controller.hideLoginPassword.value;
                          },
                          icon: controller.hideLoginPassword.value
                              ? Icon(Iconsax.eye_slash)
                              : Icon(Iconsax.eye))),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwInputFields / 2,
              ),

              // Remember Me & forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Remember me
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) =>
                              controller.rememberMe.value = value!)),
                      Text(TTexts.rememberMe),
                    ],
                  ),

                  // Forget Password
                  TextButton(
                      onPressed: () {
                        Get.toNamed(TRoutes.forgetPassword);
                      },
                      child: Text(TTexts.forgetPassword))
                ],
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.login(),
                    child: Text(TTexts.signIn)),
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // Create Account Button
              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () => Get.toNamed(TRoutes.signUp),
                      child: const Text(TTexts.createAccount))),
            ],
          ),
        ));
  }
}
