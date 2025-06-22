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

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore
  Future<void> createAdmin(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  // Function to fetch user details based on current User
  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();
      return UserModel.fromSnapshot(docSnapshot);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong : $e';
    }
  }

  // Function to fetch user details based on User Id
  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final docSnapshot = await _db.collection("Users").doc(id).get();
      return UserModel.fromSnapshot(docSnapshot);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong : $e';
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final querySnapshot =
          await _db.collection("Users").orderBy("FirstName").get();
      return querySnapshot.docs
          .map((user) => UserModel.fromSnapshot(user))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong : $e';
    }
  }


  Future<List<OrderModel>> fetchUserOrders(String id) async {
    try {
      final querySnapshot =
      await _db.collection("Orders").where("userId",isEqualTo: id).get();
      return querySnapshot.docs
          .map((user) => OrderModel.fromSnapshot(user))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong : $e';
    }
  }

// Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
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

// Update any field in specific users collection
Future<void> updateSingleField(Map<String, dynamic> json) async {
  try {
    await _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .update(json);
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

// Function to remove user data from firestore
Future<void> delete(String userId) async {
  try {
    await _db.collection("Users").doc(userId).delete();
  } on FirebaseException catch (e) {
    throw e.message!;
  }  on PlatformException catch (e) {
    throw e.message!;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}

// Upload any image
// Future<String> uploadImage(String path, XFile image) async {
//   try {
//     final ref = FirebaseStorage.instance.ref(path).child(image.name);
//     await ref.putFile(File(image.path));
//     final url = await ref.getDownloadURL();
//     return url;
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
