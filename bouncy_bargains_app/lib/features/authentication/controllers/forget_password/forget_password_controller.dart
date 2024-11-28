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

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Reset password email
  sendPasswordResetEmail() async {
    try {
      // Start Loading
      XFullScreenLoader.openLoadingDialog(
          "Processing your request", XImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Remove loader
      XFullScreenLoader.stopLoading();

      // Show success screen
      XLoaders.successSnackBar(
          title: "Email Sent",
          message: "Email Link Sent to Reset your password".tr);

      // Redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      // Remove loader
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Resend Reset password email
  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      XFullScreenLoader.openLoadingDialog(
          "Processing your request", XImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Remove loader
      XFullScreenLoader.stopLoading();

      // Show success screen
      XLoaders.successSnackBar(
          title: "Email Sent",
          message: "Email Link Sent to Reset your password".tr);
    } catch (e) {
      // Remove loader
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
