import 'package:bouncy_bargain/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/device/device_utility.dart';
import 'package:flutter/material.dart';


class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: XDeviceUtils.getAppBarHeight(),
        right: XSizes.defaultSpace,
        child: TextButton(onPressed: () => OnboardingController.instance.skipPage(), child: Text(text)));
  }
}