

import 'package:bouncy_bargain/features/shop/models/category_model.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/format_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance =>   Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllcategories()async {
    try {
        final snapshot = await _db.collection("Categories").get();
        final list =snapshot.docs.map((docuement) => CategoryModel.fromSnapshot(docuement)).toList();
        return list;
    } on FirebaseAuthException catch (e) {
      throw XFirebaseAuthException(e.code).message;
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

  // Get sub categories

  // Upload categories to the Cloud Firebase Firestore
}