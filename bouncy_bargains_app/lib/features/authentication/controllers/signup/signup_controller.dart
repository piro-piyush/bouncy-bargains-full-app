import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/data/repositories/user/user_repository.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:bouncy_bargain/features/personalization/models/user_model.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables for user input
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  // Form key for validation
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Signup method
  Future<void> signup() async {
    try {
      // Show loading indicator
      XFullScreenLoader.openLoadingDialog(
          "We are processing your information...", XImages.docerAnimation);

      // Check if the device is connected to the internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Ensure the user accepts the privacy policy
      if (!privacyPolicy.value) {
        XFullScreenLoader.stopLoading();
        XLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                "You must accept the Privacy Policy & Terms of use to continue.");
        return;
      }

      // Register user using email and password authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Create a new user object with the provided details
      final newUser = UserModel(
        id: userCredential.user!.uid,
        username: username.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture:
            "", // Placeholder for profile picture (can be updated later)
      );

      // Save the user data in Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Hide loading indicator
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Navigate to the email verification screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      // Hide loading indicator in case of error
      XFullScreenLoader.stopLoading();

      // Show error message to the user
      XLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
