import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/features/authentication/screens/password_configuration/reset_password_screen.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Controllers and Form keys
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send password reset email
  sendPasswordResetEmail() async {
    try {
      // Show loading indicator while processing the request
      XFullScreenLoader.openLoadingDialog(
          "Processing your request", XImages.docerAnimation);

      // Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return; // Stop if there's no internet connection
      }

      // Validate the form
      if (!forgetPasswordFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return; // Stop if form is not valid
      }

      // Send password reset email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Hide loading indicator
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: "Email Sent",
          message: "Email Link Sent to Reset your password".tr);

      // Redirect to the reset password screen
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Hide loading indicator in case of error
      XFullScreenLoader.stopLoading();
      // Show error message
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Resend password reset email
  resendPasswordResetEmail(String email) async {
    try {
      // Show loading indicator while processing the request
      XFullScreenLoader.openLoadingDialog(
          "Processing your request", XImages.docerAnimation);

      // Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return; // Stop if there's no internet connection
      }

      // Send password reset email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Hide loading indicator
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: "Email Sent",
          message: "Email Link Sent to Reset your password".tr);
    } catch (e) {
      // Hide loading indicator in case of error
      XFullScreenLoader.stopLoading();
      // Show error message
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
