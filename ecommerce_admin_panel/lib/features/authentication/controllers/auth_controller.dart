import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/base_user_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/admin_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  // ─────────────────────────────────────────────
  // 📦 Dependencies
  final _authRepo = AuthenticationRepository.instance;
  final _userRepo = UserRepository.instance;
  final _settingsRepo = SettingsRepository.instance;
  final localStorage = GetStorage();

  // ─────────────────────────────────────────────
  // 🔐 Login Controllers & States
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final hideLoginPassword = true.obs;
  final rememberMe = false.obs;

  // ─────────────────────────────────────────────
  // 📝 Signup Controllers & States
  final signupEmail = TextEditingController();
  final signupPassword = TextEditingController();
  final signupFirstName = TextEditingController();
  final signupLastName = TextEditingController();
  final signupUsername = TextEditingController();
  final signupPhone = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();
  final hideSignupPassword = true.obs;
  final privacyPolicyAccepted = false.obs;

  // ─────────────────────────────────────────────
  // 🔁 Reset Password Controllers
  final resetEmail = TextEditingController();
  final resetFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    loginEmail.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    loginPassword.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// 🔐 Logs in a user using email and password
  Future<void> login() async {
    try {
      TFullScreenLoader.openLoadingDialog("Logging you in...", TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // 💾 Remember Me
      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", loginEmail.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", loginPassword.text.trim());
      } else {
        localStorage.remove("REMEMBER_ME_EMAIL");
        localStorage.remove("REMEMBER_ME_PASSWORD");
      }

      // 🔑 Login
      await _authRepo.loginWithEmailAndPassword(
        loginEmail.text.trim(),
        loginPassword.text.trim(),
      );

      // 👤 Fetch admin data
      final user = await _userRepo.fetchAdmin();

      // ❌ Not admin? Logout + error
      if (user.role != AppRole.admin) {
        await _authRepo.logout();
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: "Not Authorized",
          message: "Access denied. Please contact administrator.",
        );
        return;
      }

      // ⚠️ Admin but not approved
      if (!user.hasBeenApproved) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Approval Pending",
          message: "Your account has not been approved yet.",
        );
        Get.toNamed(TRoutes.accountApproval, parameters: {'id': user.id});
        return;
      }

      // ✅ Success
      TFullScreenLoader.stopLoading();
      _authRepo.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Login Failed", message: e.toString());
    }
  }


  /// 📝 Signs up a new admin user and saves to Firestore
  Future<void> signup() async {
    try {
      TFullScreenLoader.openLoadingDialog("Registering...", TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicyAccepted.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'You must accept the Privacy Policy & Terms of Use to continue.',
        );
        return;
      }


      final firstName = signupFirstName.text.trim();
      final lastName = signupLastName.text.trim();
      final fullName = '$firstName $lastName';
      String? userName;
      if(signupUsername.text.isEmpty){
        userName = BaseUserModel.generateUsername(fullName);
      }else {
        userName = signupUsername.text.trim();
      }
      final email = signupEmail.text.trim();
      final phoneNumber = signupPhone.text.trim();
      final password = signupPassword.text.trim();

      // 🔐 Register with Firebase
      final userCred = await _authRepo.registerWithEmailAndPassword(
        email,
        password,
      );

      // 📝 Create Admin record
      final newAdmin = AdminModel(
        id: userCred.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
        username: userName,
        phoneNumber:phoneNumber,
        hasBeenApproved: false,
      );

      await _userRepo.createAdmin(newAdmin);

      // Optional: Create default settings
      await _settingsRepo.registerSettings(SettingsModel(
        appLogo: "",
        appName: "My App",
        shippingCost: 0.0,
        taxRate: 0,
        freeShippingThreshold: 400,
      ));

      // ✅ Now check approval status
      final user = await _userRepo.fetchAdmin();

      if (user.role != AppRole.admin) {
        await _authRepo.logout();
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: "Not Authorized",
          message: "Access denied. Please contact administrator.",
        );
        return;
      }

      if (!user.hasBeenApproved) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Approval Pending",
          message: "Your account has not been approved yet.",
        );
        Get.toNamed(TRoutes.accountApproval, parameters: {'id': user.id});
        return;
      }

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Welcome!",
        message: "Account created successfully.",
      );
      _authRepo.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Signup Failed", message: e.toString());
    }
  }


  /// 🔁 Sends a password reset email
  Future<void> resetPassword() async {
    try {
      if (!resetFormKey.currentState!.validate()) return;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection.",
        );
        return;
      }

      TFullScreenLoader.openLoadingDialog("Processing...", TImages.docerAnimation);
      await _authRepo.sendPasswordResetEmail(resetEmail.text.trim());

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "A reset link has been sent to your email.",
      );

      Get.toNamed(TRoutes.resetPassword, parameters: {"email": resetEmail.text.trim()});
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }


  /// 🔁 Sends a password reset email again
  Future<void> resendPasswordResetLink() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection.",
        );
        return;
      }
      await _authRepo.sendPasswordResetEmail(resetEmail.text.trim());
      TLoaders.successSnackBar(
        title: "Email Sent",
        message: "A reset link has been sent to your email.",
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  /// 🧾 Checks whether user is approved by admin
  Future<void> checkApproval() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.warningSnackBar(
          title: "No Internet",
          message: "Please check your connection.",
        );
        return;
      }

      TFullScreenLoader.openLoadingDialog("Checking approval status...", TImages.docerAnimation);

      final user = await _userRepo.fetchAdmin();

      if (user.hasBeenApproved) {
        if (user.role == AppRole.admin) {
          TFullScreenLoader.stopLoading();
          TLoaders.successSnackBar(
            title: "Account Approved",
            message: "You're now approved to login.",
          );
          _authRepo.screenRedirect();
        } else {
          await _authRepo.logout();
          TFullScreenLoader.stopLoading();
          TLoaders.errorSnackBar(
            title: "Access Denied",
            message: "You are not authorized as admin.",
          );
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
          title: "Not Approved Yet",
          message: "Your account is pending approval by admin.",
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  // /// 🧹 Dispose all controllers
  // @override
  // void onClose() {
  //   loginEmail.dispose();
  //   loginPassword.dispose();
  //   signupEmail.dispose();
  //   signupPassword.dispose();
  //   signupFirstName.dispose();
  //   signupLastName.dispose();
  //   signupUsername.dispose();
  //   signupPhone.dispose();
  //   resetEmail.dispose();
  //   super.onClose();
  // }
}
