import 'package:ecommerce_admin_panel/features/authentication/controllers/forget_password_controller.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordWidget extends StatelessWidget {
   ResetPasswordWidget({
    super.key,
  });

  final controller = ForgetPasswordController.instance;

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';
    return Column(
      children: [
        // Header
        Row(
          children: [
            IconButton(
                onPressed: () => Get.offAllNamed(TRoutes.login),
                icon: Icon(Icons.clear)),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        const Image(
          image: AssetImage(TImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        Text(
          TTexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          email,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text(
          TTexts.changeYourPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => Get.offAllNamed(TRoutes.login),
              child: Text(TTexts.done)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
              onPressed: () {
                controller.resend(email);
              },
              child: Text(TTexts.resendEmail)),
        ),
      ],
    );
  }
}
