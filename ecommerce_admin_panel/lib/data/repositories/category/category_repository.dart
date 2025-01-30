import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all categories from the "categories" collection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final result =
          snapshot.docs.map((doc) => CategoryModel.fromSnapShot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Delete an existing category from the "categories" collection
  Future<void> deleteCategory({required String categoryId}) async {
    try {
          await _db.collection("Categories").doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Create a category in "categories" collection
  Future<String> createCategory({required CategoryModel categoryModel}) async {
    try {
      final data =
          await _db.collection("Categories").add(categoryModel.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Update a category in "categories" collection
  Future<void> updateCategory({required CategoryModel categoryModel}) async {
    try {
      await _db
          .collection("Categories")
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }
}
