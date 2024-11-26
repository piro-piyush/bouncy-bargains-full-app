import 'package:bouncy_bargain/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/device/device_utility.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Positioned(
        right: XSizes.defaultSpace,
        bottom: XDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: dark ? XColors.primary : Colors.black),
            onPressed: () => OnboardingController.instance.nextPage(),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}
