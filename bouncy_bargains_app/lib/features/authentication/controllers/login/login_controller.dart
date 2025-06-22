import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Reactive variables
  final rememberMe = false.obs; // To store "remember me" status
  final hidePassword = true.obs; // To toggle password visibility
  final email = TextEditingController(); // Controller for email input
  final phoneNumber = TextEditingController(); // Controller for phone number input
  final password = TextEditingController(); // Controller for password input
  final localStorage = GetStorage(); // Instance for localStorage

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(); // Form key for validation
  final userController = Get.put(UserController()); // Instance of UserController

  @override
  void onInit() {
    super.onInit();
    // Check if "REMEMBER_ME" is saved in local storage
    final storedRememberMe = localStorage.read("REMEMBER_ME") ?? false;

    // If "REMEMBER_ME" is true, load saved credentials
    if (storedRememberMe) {
      rememberMe.value = true;
      email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
      password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    }
  }

  // Email and password login method
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Show loading dialog while processing login
      XFullScreenLoader.openLoadingDialog(
          "Logging you in", XImages.docerAnimation);

      // Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return; // Stop if there's no internet connection
      }

      // Validate the form before proceeding
      if (!loginFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return; // Stop if form is not valid
      }

      // Save credentials if "Remember me" is checked
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME", true); // Save "Remember me" status
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      } else {
        // Remove saved credentials if "Remember me" is unchecked
        localStorage.remove("REMEMBER_ME");
        localStorage.remove("REMEMBER_ME_EMAIL");
        localStorage.remove("REMEMBER_ME_PASSWORD");
      }

     await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Stop loading indicator
      XFullScreenLoader.stopLoading();

      // Redirect to appropriate screen after successful login
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Handle errors and stop loading indicator
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google SignIn authentication method
  Future<void> googleSignIn() async {
    try {
      // Show loading dialog during Google login
      XFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        XImages.docerAnimation,
      );

      // Check for internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return; // Stop if there's no internet connection
      }

      // Attempt Google Sign-In
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save the user record in the database
      await userController.saveUserRecord(userCredentials);

      // Stop loading indicator
      XFullScreenLoader.stopLoading();

      // Redirect to the appropriate screen after successful login
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Handle errors and stop loading indicator
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
