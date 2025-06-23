import 'package:ecommerce_admin_panel/features/authentication/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),

        // Form
        Form(
          key: controller.resetFormKey,
          child: TextFormField(
            controller: controller.resetEmail,
            decoration: InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
            validator: TValidator.validateEmail,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.resetPassword(), child: Text(TTexts.submit)),
        )
      ],
    );
  }
}
