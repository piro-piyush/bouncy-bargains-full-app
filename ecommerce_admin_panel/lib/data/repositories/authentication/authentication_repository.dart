import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  /// Singleton instance for global access
  static AuthenticationRepository get instance => Get.find();

  /// Firebase Auth instance to manage authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Repository to manage Firestore-based user records
  final UserRepository userRepo = Get.put(UserRepository());

  /// Local storage handler
  final GetStorage deviceStorage = GetStorage();

  /// Currently authenticated Firebase user
  User? get authUser => _auth.currentUser;

  /// Boolean indicating if user is already logged in
  bool get isAuthenticated => _auth.currentUser != null;

  /// Called automatically on app startup
  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
    screenRedirect();
  }

  /// Redirect user based on login and profile status
  Future<void> screenRedirect() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        final admin = await userRepo.fetchAdmin();

        if (admin.role == AppRole.admin) {
          if (admin.hasBeenApproved) {
            Get.offAllNamed(TRoutes.dashboard);
          } else {
            TLoaders.warningSnackBar(
              title: "Approval Pending",
              message: "Your admin account is not approved yet.",
            );
            Get.offAllNamed(
              TRoutes.accountApproval,
            );
          }
        } else {
          await logout();
          TLoaders.errorSnackBar(
            title: "Not Authorized",
            message: "You are not an admin. Contact administrator.",
          );
        }
      } else {
        Get.offAllNamed(TRoutes.login);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
      Get.offAllNamed(TRoutes.login);
    }
  }

  /// Login with email and password using Firebase Auth
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
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
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Register a new user with Firebase using email and password
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
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Sends a password reset email to the user
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Logout the current user from Firebase
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
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Completely delete user account from Firebase Auth and Firestore
  Future<void> deleteAccount() async {
    try {
      await userRepo.deleteAdminRecord();
      await _auth.currentUser?.delete();
      Get.offAllNamed(TRoutes.login);
    } catch (e) {
      throw 'Something went wrong while deleting account.';
    }
  }

  /// Show a confirmation dialog before logout
  Future<void> logoutConfirmationDialog() async {
    return showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Show a confirmation dialog before deleting the account
  Future<void> deleteAccountConfirmationDialog() async {
    return showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'This will permanently delete your account. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await deleteAccount();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
