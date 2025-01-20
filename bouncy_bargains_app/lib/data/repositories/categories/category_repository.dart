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
  // Singleton pattern for accessing CategoryRepository instance
  static CategoryRepository get instance => Get.find();

  // Firestore instance for interacting with the database
  final _db = FirebaseFirestore.instance;

  // Fetch all categories from Firestore
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      // Retrieve the categories from the "Categories" collection
      final snapshot = await _db.collection("Categories").get();

      // Map each document to a CategoryModel object and return as a list
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      // Handle general Firebase exceptions
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Handle invalid format exceptions
      throw const XFormatException();
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions
      throw XPlatformException(e.code).message;
    } catch (e) {
      // Catch any other unexpected errors
      throw 'Something went wrong. Please try again';
    }
  }

  // Upload categories to Firebase Firestore along with their image URLs
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Initialize FirebaseStorageService for image upload handling
      final storage = Get.put(XFirebaseStorageService());

      // Loop through each category to upload its image and data
      for (var category in categories) {
        // Get image data from local assets based on category image URL
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload image data to Firebase Storage and retrieve the URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Update category image with the newly uploaded URL
        category.image = url;

        // Store the updated category object in Firestore
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Handle format-related exceptions
      throw const XFormatException();
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions
      throw XPlatformException(e.code).message;
    } catch (e) {
      // Handle any other errors during the upload process
      throw 'Something went wrong. Please try again';
    }
  }
}
