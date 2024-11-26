import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(XSizes.defaultSpace),
        child: Column(
          children: [
            // Image with 60%  of screen width
            Image(
                width: XHelperFunctions.screenWidth() * 0.6,
                image: const AssetImage(XImages.deliveredEmailIllustration)),
            const SizedBox(
              height: XSizes.spaceBtwSections,
            ),

            // Title & Subtitle
            Text(
              XTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems,
            ),
            Text(
              XTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems,
            ),

            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text(XTexts.done)),
            ),
            const SizedBox(
              height: XSizes.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(XTexts.resendEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
