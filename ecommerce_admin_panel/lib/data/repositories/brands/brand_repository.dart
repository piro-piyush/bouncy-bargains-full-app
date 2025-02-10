import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all brands from the "brands" collection
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final result =
          snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Get all the brand categories from the "brand_categories" collection
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final brandCategoryQuery = await _db.collection("BrandCategory").get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Get specific brand categories for a given id
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final snapshot = await _db
          .collection("BrandCategory")
          .where("brandId", isEqualTo: brandId)
          .get();
      final brandCategories = snapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Create a new brand document in the "Brands" collection
  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection("Brands").add(brand.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Create a new brand category document in the "BrandCategory" collection
  Future<String> createBrandCategory(
      BrandCategoryModel brandCategoryModel) async {
    try {
      final result = await _db
          .collection("BrandCategory")
          .add(brandCategoryModel.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Update an existing brand document in the "Brands" collection
  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Delete an existing brand document and its associated brand categories
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection("Brands").doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand not found');
        }
        final brandCategoriesSnapshot = await _db
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCategoriesSnapshot.docs
            .map((doc) => BrandCategoryModel.fromSnapshot(doc))
            .toList();

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction
                .delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }
        // Delete the brand document
        transaction.delete(brandRef);
      });
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // delete a brand category document in the "BrandCategory" collection
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }
}
