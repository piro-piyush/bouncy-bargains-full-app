import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 👤 `UserRepository`
/// - Handles all Firestore operations related to users and their orders.
/// - Provides methods for CRUD, user-specific fetch, and updates.
class UserRepository extends GetxController {
  /// Singleton instance
  static UserRepository get instance => Get.find();

  /// Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ------------------------- 🔐 CREATE -------------------------

  /// 🔸 Create a new user/admin in the Firestore
  Future<void> createAdmin(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  // ------------------------- 📥 READ -------------------------

  /// 🔹 Fetch current logged-in admin's profile
  Future<UserModel> fetchAdminDetails() async {
    try {
      final doc = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      return UserModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong : $e';
    }
  }

  /// 🔹 Fetch user profile by their ID
  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final doc = await _db.collection("Users").doc(id).get();
      return UserModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong : $e';
    }
  }

  /// 🔹 Fetch all registered users (sorted by first name)
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot =
      await _db.collection("Users").orderBy("FirstName").get();
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong : $e';
    }
  }

  /// 🔹 Fetch all orders placed by a specific user
  Future<List<OrderModel>> fetchUserOrders(String id) async {
    try {
      final snapshot = await _db
          .collection("Orders")
          .where("userId", isEqualTo: id)
          .get();
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong : $e';
    }
  }

  // ------------------------- 📝 UPDATE -------------------------

  /// 🔸 Update full user model in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// 🔸 Update single field(s) for current logged-in user
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final uid = AuthenticationRepository.instance.authUser?.uid;
      if (uid != null) {
        await _db.collection("Users").doc(uid).update(json);
      } else {
        throw 'User not authenticated';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  // ------------------------- ❌ DELETE -------------------------

  /// 🔻 Delete user document by ID
  Future<void> delete(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }
}
