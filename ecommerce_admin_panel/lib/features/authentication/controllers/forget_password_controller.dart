import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/routes/app_screens.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 🔐 ForgetPasswordController
/// Handles password reset flow with validation, loading UI, and Firebase integration.
class ForgetPasswordController extends GetxController {
  // Singleton Instance
  static ForgetPasswordController get instance => Get.find();

  // Dependencies
  final _authRepo = AuthenticationRepository.instance;

  // UI Form
  final email = TextEditingController();
  final resetKey = GlobalKey<FormState>();

  /// 🔁 Triggers password reset flow
  Future<void> submit() async {
    try {
      // ✅ Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection and try again.",
        );
        return;
      }

      // ✅ Form validation
      if (!resetKey.currentState!.validate()) return;

      // ⏳ Show loading
      TFullScreenLoader.openLoadingDialog(
        "Processing your request...",
        TImages.docerAnimation,
      );

      // 🔐 Firebase password reset
      await _authRepo.sendPasswordResetEmail(email.text.trim());

      // ✅ Stop loading & notify user
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "A reset link has been sent to your email.",
      );

      // 👉 Navigate to reset screen
      Get.toNamed(AppScreens.resetPassword,parameters: {
        "email":email.text.trim()
      });
    } catch (e) {
      // ❌ Error handling
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }




  /// 🔁 Triggers password reset link resend
  Future<void> resend(String email) async {
    try {
      // ✅ Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection and try again.",
        );
        return;
      }


      // 🔐 Firebase password reset
      await _authRepo.sendPasswordResetEmail(email);

      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "A reset link has been sent to your email.",
      );

    } catch (e) {
      TLoaders.errorSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    }
  }
}
