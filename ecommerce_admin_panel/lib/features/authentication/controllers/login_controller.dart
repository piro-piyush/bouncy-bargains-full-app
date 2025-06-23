import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final authRepo = AuthenticationRepository.instance;
  final userRepo = UserRepository.instance;
  final settingsRepo = SettingsRepository.instance;


  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Handles email and password sign-in process
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          "Logging you in...", TImages.docerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
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
      await authRepo.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Create Admin record in the firestore
      final user = await userRepo.fetchUserDetails(
        authRepo.authUser?.uid ?? "",
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // If the user is not admin, logout and return
      if (user.role != AppRole.admin) {
        await authRepo.logout();
        TLoaders.errorSnackBar(
            title: "Not Authorized",
            message: "You are not authorized or do have access. Contact Admin");
      } else {
        // Redirect
        authRepo.screenRedirect();
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Registering Admin Account...", TImages.docerAnimation);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user with Email & password Authentication
      await authRepo.registerWithEmailAndPassword(
          TTexts.adminEmail, TTexts.adminPassword);

      // Create Admin record in the firestore
      await userRepo.createAdmin(UserModel(
        id: authRepo.authUser!.uid,
        firstName: "Bouncy Bargains",
        lastName: "Admin",
        email: TTexts.adminEmail,
        role: AppRole.admin,
        createdAt: DateTime.now(),
      ));

      await settingsRepo.registerSettings(SettingsModel(
        appName: "My App",
        appLogo: "",
        taxRate: 0,
        shippingCost: 0
      ));
      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      authRepo.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
