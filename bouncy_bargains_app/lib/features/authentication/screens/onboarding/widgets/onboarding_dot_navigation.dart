
import 'package:bouncy_bargain/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/device/device_utility.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    final controller = OnboardingController.instance;
    return Positioned(
        bottom: XDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: XSizes.defaultSpace,
        child: SmoothPageIndicator(
            effect: ExpandingDotsEffect(
              activeDotColor: dark ? XColors.white : XColors.dark,
              dotHeight: 6,
            ),
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3));
  }
}
