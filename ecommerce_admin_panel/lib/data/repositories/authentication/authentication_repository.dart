import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated user data
  User? get authUser => _auth.currentUser;

  // Get isAuthenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  // Called from main.dart on app launch
  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
    screenRedirect();
  }


  void screenRedirect() async {
    final user = _auth.currentUser;

    // If the user is logged in
    if (user != null) {
      // Navigate to the dashboard
      Get.offAllNamed(TRoutes.dashboard);
    } else {
      Get.offAllNamed(TRoutes.login);
    }
  }

/*-------------------------------- Email & Password sign-in ------------------*/

  // [EmailAuthentication] - Login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - Mail Verification
// Future<void> sendEmailVerification() async {
//   try {
//     await _auth.currentUser?.sendEmailVerification();
//   } on FirebaseAuthException catch (e) {
//     throw XFirebaseAuthException(e.code).message;
//   } on FirebaseException catch (e) {
//     throw XFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const XFormatException();
//   } on PlatformException catch (e) {
//     throw XPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something went wrong. Please try again';
//   }
// }

  /// [ReAuthenticate] - ReAuthenticate User
// Future<void> reAuthenticateEmailAndPasswordUser(String email, String password) async {
//   try {
//     // Create a credential
//     AuthCredential credential =
//     EmailAuthProvider.credential(email: email, password: password);
//
//     // ReAuthenticate
//     await _auth.currentUser!.reauthenticateWithCredential(credential);
//   } on FirebaseAuthException catch (e) {
//     throw XFirebaseAuthException(e.code).message;
//   } on FirebaseException catch (e) {
//     throw XFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const XFormatException();
//   } on PlatformException catch (e) {
//     throw XPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something went wrong. Please try again';
//   }
// }

  /// [EmailAuthentication] - Forget Password
// Future<void> sendPasswordResetEmail(String email,) async {
//   try {
//     await _auth.sendPasswordResetEmail(email: email);
//   } on FirebaseAuthException catch (e) {
//     throw XFirebaseAuthException(e.code).message;
//   } on FirebaseException catch (e) {
//     throw XFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const XFormatException();
//   } on PlatformException catch (e) {
//     throw XPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something went wrong. Please try again';
//   }
// }

/*-------------------------------- Federated identity & social sign-in ------------------*/

  /// [GoogleAuthentication] -   Google
// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//     await userAccount?.authentication;
//
//     // Create a new credential
//     final credentials = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//
//     // Once signed in , return the user credential
//     return await _auth.signInWithCredential(credentials);
//   } on FirebaseAuthException catch (e) {
//     throw XFirebaseAuthException(e.code).message;
//   } on FirebaseException catch (e) {
//     throw XFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const XFormatException();
//   } on PlatformException catch (e) {
//     throw XPlatformException(e.code).message;
//   } catch (e) {
//     if (kDebugMode) print('Something went wrong : $e');
//     return null;
//   }
// }

  /// [FacebookAuthentication] - Facebook

/*-------------------------------- Federated identity & social sign-in ------------------*/

  /// [LogoutUser] - Valid for any Authentication
Future<void> logout() async {
  try {
    await _auth.signOut();
    Get.offAllNamed(TRoutes.login);
  } on FirebaseAuthException catch (e) {
    throw TFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}

  /// [DeleteUser] - Remove User Auth and Firestore Account
// Future<void> deleteAccount() async {
//   try {
//     await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
//     await _auth.currentUser?.delete();
//   } on FirebaseAuthException catch (e) {
//     throw XFirebaseAuthException(e.code).message;
//   } on FirebaseException catch (e) {
//     throw XFirebaseException(e.code).message;
//   } on FormatException catch (_) {
//     throw const XFormatException();
//   } on PlatformException catch (e) {
//     throw XPlatformException(e.code).message;
//   } catch (e) {
//     throw 'Something went wrong. Please try again';
//   }
// }
}
