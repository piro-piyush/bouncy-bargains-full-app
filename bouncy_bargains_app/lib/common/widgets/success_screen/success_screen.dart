import 'package:bouncy_bargain/common/styles/spacing_styles.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed,
      this.isLottie = false});

  final String image, title, subTitle;
  final bool isLottie;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: XSpacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              isLottie
                  ? Lottie.asset(image,
                      width: XHelperFunctions.screenWidth() * 0.6)
                  : Image(
                      width: XHelperFunctions.screenWidth() * 0.6,
                      image: AssetImage(image)),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Title & Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),
              Text(
                subTitle,
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
                    onPressed: onPressed, child: const Text(XTexts.xContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
