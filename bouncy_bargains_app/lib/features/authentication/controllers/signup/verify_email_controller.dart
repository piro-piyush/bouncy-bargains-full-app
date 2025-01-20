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

  // Send Email Verification and set a timer for auto-redirect when screen appears
  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  // Sends Email Verification Link to the user
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      XLoaders.successSnackBar(
          title: "Email Sent",
          message: "Please check your inbox and verify your email");
    } catch (e) {
      XLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Sets a timer to periodically check email verification status
  setTimerForAutoRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      // If email is verified, cancel the timer and redirect to success screen
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

  // Manually checks if the email is verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.emailVerified) {
      // Redirect to success screen if email is verified
      Get.off(() => SuccessScreen(
          image: XImages.successfullyRegistrationAnimation,
          isLottie: true,
          title: XTexts.yourAccountCreatedTitle,
          subTitle: XTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
