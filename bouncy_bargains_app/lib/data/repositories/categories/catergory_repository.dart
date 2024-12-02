import 'package:bouncy_bargain/data/services/cloud_storage/firebase_storage_service.dart';
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
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final list = snapshot.docs
          .map((docuement) => CategoryModel.fromSnapshot(docuement))
          .toList();
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
  Future<void> uploadDummyData(
      List<CategoryModel> categories) async {
    try {
      // Upload all the categories along with their images
      final storage = Get.put(XFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get imageData link from local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload image and get its Url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Assign  URL to Category.image attribute
        category.image = url;

        // Store category in Firestore
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
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
}
