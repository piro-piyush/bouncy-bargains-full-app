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

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController(); // Controller for email input
  final phoneNumber =
      TextEditingController(); // Controller for phone number input
  final password = TextEditingController(); // Controller for password input
  final localStorage = GetStorage();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    // Check if "REMEMBER_ME" was previously saved in local storage
    final storedRememberMe = localStorage.read("REMEMBER_ME") ?? false;

    // If "REMEMBER_ME" was saved, set the rememberMe variable and populate email/password
    if (storedRememberMe) {
      rememberMe.value = true;
      email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
      password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    }
  } // Form key for form validation

  // Email and password login
  Future<void> emailAndPasswordSignIn() async {
    try {
      XFullScreenLoader.openLoadingDialog(
          "Logging you in", XImages.docerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember me is selected
      if (rememberMe.value) {
        localStorage.write(
            "REMEMBER_ME", true); // Save the "Remember me" status
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      } else {
        localStorage
            .remove("REMEMBER_ME"); // If not selected, remove the saved data
        localStorage.remove("REMEMBER_ME_EMAIL");
        localStorage.remove("REMEMBER_ME_PASSWORD");
      }

      // Login user with Email & password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      XFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google SignIn authentication
  Future<void> googleSignIn() async {
    try {
      // Start loading
      XFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        XImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user Record
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      XFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      XFullScreenLoader.stopLoading();

      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
