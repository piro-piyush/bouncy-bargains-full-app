import 'package:bouncy_bargain/features/personalization/models/user_model.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/format_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const XFormatException();
    } on PlatformException catch (e) {
      throw XPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

// Function to fetch user details based on User Id

// Function to update user data in Firestore

// Update any field in specific users collection
}
