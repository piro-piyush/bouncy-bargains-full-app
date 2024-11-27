import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/format_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

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
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw XFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw XFormatException;
    } on PlatformException catch (e) {
      throw XPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

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
