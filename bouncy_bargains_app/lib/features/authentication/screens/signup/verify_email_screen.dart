import 'package:bouncy_bargain/common/widgets/success_screen/success_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                  width: XHelperFunctions.screenWidth() * 0.6,
                  image: const AssetImage(XImages.deliveredEmailIllustration)),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Title & Subtitle
              Text(
                XTexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),
              Text(
                "support@bouncy_bargain@gmail.com",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),
              Text(
                XTexts.confirmEmailSubTitle,
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
                    onPressed: () {
                      Get.to(() => SuccessScreen(
                            image: XImages.staticSuccessIllustration,
                            title: XTexts.yourAccountCreatedTitle,
                            subTitle: XTexts.yourAccountCreatedSubTitle,
                            onPressed: () => Get.to(() => const LoginScreen()),
                          ));
                    },
                    child: const Text(XTexts.xContinue)),
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
      ),
    );
  }
}
