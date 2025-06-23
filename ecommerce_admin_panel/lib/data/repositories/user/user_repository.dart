import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/admin_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 👤 UserRepository handles CRUD for both Admins and Users
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String adminsCollection = 'Admins';
  final String usersCollection = 'Users';

  // ----------------------------- 🔐 Admin Methods -----------------------------

  /// 🔸 Create a new admin
  Future<void> createAdmin(AdminModel admin) async {
    try {
      await _db.collection(adminsCollection).doc(admin.id).set(admin.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔹 Fetch current logged-in admin's profile
  Future<AdminModel> fetchAdmin() async {
    try {
      final doc = await _db
          .collection(adminsCollection)
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      return AdminModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong: $e';
    }
  }

  /// 🔸 Update full admin model
  Future<void> updateAdminDetails(AdminModel admin) async {
    try {
      await _db.collection(adminsCollection).doc(admin.id).update(admin.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔸 Update single admin field
  Future<void> updateAdminField(Map<String, dynamic> json) async {
    try {
      final uid = AuthenticationRepository.instance.authUser?.uid;
      if (uid != null) {
        await _db.collection(adminsCollection).doc(uid).update(json);
      } else {
        throw 'Admin not authenticated';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔻 Delete admin account
  Future<void> deleteAdminRecord() async {
    try {
      final uid = AuthenticationRepository.instance.authUser?.uid;
      if (uid != null) {
        await _db.collection(adminsCollection).doc(uid).delete();
      } else {
        throw 'Admin not authenticated';
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // ----------------------------- 👥 User Methods -----------------------------

  /// 🔸 Create a new user (if needed)
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection(usersCollection).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔹 Fetch user by ID
  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final doc = await _db.collection(usersCollection).doc(id).get();
      return UserModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong: $e';
    }
  }

  /// 🔹 Fetch all users (sorted by first name)
  Future<List<UserModel>> getAllUsers() async {
    try {
      final snapshot = await _db.collection(usersCollection).orderBy("FirstName").get();
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong: $e';
    }
  }

  /// 🔸 Update full user model
  Future<void> updateUserDetails(UserModel user) async {
    try {
      await _db.collection(usersCollection).doc(user.id).update(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔸 Update specific field(s) for user
  Future<void> updateUserField(String userId, Map<String, dynamic> json) async {
    try {
      await _db.collection(usersCollection).doc(userId).update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🔻 Delete user by ID
  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection(usersCollection).doc(userId).delete();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
