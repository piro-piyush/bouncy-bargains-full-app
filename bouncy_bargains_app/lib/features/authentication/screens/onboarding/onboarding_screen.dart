import 'package:bouncy_bargain/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnboardingPage(
              image: XImages.onBoardingImage1,
              title: XTexts.onBoardingTitle1,
              subtitle: XTexts.onBoardingSubTitle1,
            ),
            OnboardingPage(
              image: XImages.onBoardingImage2,
              title: XTexts.onBoardingTitle2,
              subtitle: XTexts.onBoardingSubTitle2,
            ),
            OnboardingPage(
              image: XImages.onBoardingImage3,
              title: XTexts.onBoardingTitle3,
              subtitle: XTexts.onBoardingSubTitle3,
            )
          ],
        ),
        const OnboardingSkip(
          text: "Skip",
        ),
        const OnboardingDotNavigation(),
        const OnboardingNextButton()
      ]),
    );
  }
}
