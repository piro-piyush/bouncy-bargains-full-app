import 'package:ecommerce_admin_panel/features/authentication/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/sign_up/widgets/terms_and_conditions_widget.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            // First & Last name
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name', value),
                    controller: controller.signupFirstName,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller.signupLastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Username
            TextField(
              controller: controller.signupUsername,
              decoration: const InputDecoration(
                  labelText: "${TTexts.username} ${TTexts.optional}",
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Email
            TextFormField(
              controller: controller.signupEmail,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Phone Number
            TextFormField(
              controller: controller.signupPhone,
              validator: (value) => TValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.signupPassword,
                obscureText: controller.hideSignupPassword.value,
                validator: (value) => TValidator.validatePassword(value),
                decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hideSignupPassword.value =
                          !controller.hideSignupPassword.value,
                      icon: controller.hideSignupPassword.value
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye)),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Terms&Conditions CheckBox
            const TermsAndConditionsWidget(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Signup Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(TTexts.createAccount)),
            )
          ],
        ));
  }
}
