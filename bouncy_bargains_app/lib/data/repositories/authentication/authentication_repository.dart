import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();

  // Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to show Relevant Screen
  screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull('isFirstTime', true);
    deviceStorage.read("isFirstTime") != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnboardingScreen());
  }

/*-------------------------------- Email & Password sign-in ------------------*/

  /// [EmailAuthentication] - SignIn

  /// [EmailAuthentication] - Register

  /// [ReAuthenticate] - ReAuthenticate User

  /// [EmailVerification] - Mail Verification

  /// [EmailAuthentication] - Forget Password

/*-------------------------------- Federated identity & social sign-in ------------------*/

  /// [GoogleAuthentication] -   Google

  /// [FacebookAuthentication] - Facebook

/*-------------------------------- Federated identity & social sign-in ------------------*/

  /// [LogoutUser] - Valid for any Authentication

  /// [DeleteUser] - Remove User Auth and Firestore Account
}
