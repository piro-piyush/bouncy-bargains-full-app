import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

// Function to fetch user details based on User Id
//   Future<UserModel> fetchUserDetails() async {
//     try {
//       final docuementSnapshot = await _db
//           .collection("Users")
//           .doc(AuthenticationRepository.instance.authUser?.uid)
//           .get();
//       if (docuementSnapshot.exists) {
//         return UserModel.fromSnapshot(docuementSnapshot);
//       } else {
//         return UserModel.empty();
//       }
//     } on FirebaseException catch (e) {
//       throw XFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const XFormatException();
//     } on PlatformException catch (e) {
//       throw XPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again';
//     }
//   }

// Function to update user data in Firestore
//   Future<void> updateUserData(UserModel updatedUser) async {
//     try {
//       await _db
//           .collection("Users")
//           .doc(updatedUser.id)
//           .update(updatedUser.toJson());
//     } on FirebaseException catch (e) {
//       throw XFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const XFormatException();
//     } on PlatformException catch (e) {
//       throw XPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong. Please try again';
//     }
//   }

// Update any field in specific users collection
// Future<void> updateSingleField(Map<String, dynamic> json) async {
//   try {
//     await _db
//         .collection("Users")
//         .doc(AuthenticationRepository.instance.authUser?.uid)
//         .update(json);
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

// Function to remove user data from firestore
// Future<void> removeUserRecord(String userId) async {
//   try {
//     await _db.collection("Users").doc(userId).delete();
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