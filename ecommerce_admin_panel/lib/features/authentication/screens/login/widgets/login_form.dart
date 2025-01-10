import 'package:ecommerce_admin_panel/features/authentication/controllers/login_controller.dart';
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
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              // Email
              TextFormField(
                controller: controller.email,
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
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
                  validator: (value) =>
                      TValidator.validateEmptyText("Password", value),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: controller.hidePassword.value
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
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: Text(TTexts.signIn)),
              )
            ],
          ),
        ));
  }
}
