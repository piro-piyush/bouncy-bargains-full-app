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

  // Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController(); // Controller for first name input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for user name input
  final email = TextEditingController(); // Controller for email input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input
  final password = TextEditingController(); // Controller for password input

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form key for form validation

  // Signup
  Future<void> signup() async {
    try {
      // Start Loading
      XFullScreenLoader.openLoadingDialog(
          "We are processing your information...", XImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        XFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        XFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        // Remove Loader
        XFullScreenLoader.stopLoading();
        XLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                "In order to create account, you must have to read and accept the Privacy Policy & Terms of use.");
        return;
      }

      // Register user in firebase authentication & save user data in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save authenticated user data in the firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        username: username.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Move to verify email screen
      Get.to(() => const VerifyEmailScreen());
    } catch (e) {
      // Remove Loader
      XFullScreenLoader.stopLoading();
      // Show some Generic error to the user
      XLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
