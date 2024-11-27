import 'dart:async';

import 'package:bouncy_bargain/common/widgets/success_screen/success_screen.dart';
import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // Send Email Whenever Verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Email Verification Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      XLoaders.successSnackBar(
          title: "Email sent",
          message: "Please check your inbox and verify your email");
    } catch (e) {
      XLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Timer to automatically redirect on Email verification
  setTimerForAutoRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: XImages.successfullyRegistrationAnimation,
            isLottie: true,
            title: XTexts.yourAccountCreatedTitle,
            subTitle: XTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  // Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: XImages.successfullyRegistrationAnimation,
          isLottie: true,
          title: XTexts.yourAccountCreatedTitle,
          subTitle: XTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
