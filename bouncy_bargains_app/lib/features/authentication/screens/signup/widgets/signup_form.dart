import 'package:bouncy_bargain/features/authentication/controllers/signup/signup_controller.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/widgets/terms_and%20_conditions_checkbox.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XSignupForm extends StatelessWidget {
  const XSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
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
                        XValidator.validateEmptyText('First Name', value),
                    controller: controller.firstName,
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
                    controller: controller.lastName,
                    validator: (value) =>
                        XValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                        labelText: XTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: XSizes.spaceBtwSections,
            ),

            // Username
            TextFormField(
              controller: controller.username,
              validator: (value) =>
                  XValidator.validateEmptyText('Username', value),
              decoration: const InputDecoration(
                  labelText: XTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: XSizes.spaceBtwInputFields,
            ),

            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => XValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: XTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: XSizes.spaceBtwInputFields,
            ),

            // Phone Number
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => XValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: XTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: XSizes.spaceBtwInputFields,
            ),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                validator: (value) => XValidator.validatePassword(value),
                decoration: InputDecoration(
                  labelText: XTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: controller.hidePassword.value
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye)),
                ),
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
                  onPressed: () => controller.signup(),
                  child: const Text(XTexts.createAccount)),
            )
          ],
        ));
  }
}
