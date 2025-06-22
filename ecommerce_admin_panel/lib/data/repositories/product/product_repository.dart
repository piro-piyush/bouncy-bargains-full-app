import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /* ---------------- Function ----------------------*/

  // Create a new Product
  Future<String> createProduct({required ProductModel product}) async {
    try {
      final result = await _db.collection("Products").add(product.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Create a new Product category
  Future<String> createProductCategory(
      {required ProductCategoryModel productCategory}) async {
    try {
      final result =
          await _db.collection("ProductCategory").add(productCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Update a product
  Future<void> updateProduct({required ProductModel product}) async {
    try {
      await _db.collection("Products").doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Delete a Product from Firestore
  Future<void> deleteProduct({required String productId}) async {
    try {
      // Delete all data at once from Firebase firestore
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(productId);
        final productSnap = await transaction.get(productRef);
        if (!productSnap.exists) {
          throw Exception("Product not found");
        }
        // Fetch the productCategories
        final productCategoriesSnapshot = await _db
            .collection("ProductCategory")
            .where('productId', isEqualTo: productId)
            .get();
        final productCategories = productCategoriesSnapshot.docs
            .map((doc) => ProductCategoryModel.fromSnapshot(doc));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(_db
                .collection("ProductCategory")
                .doc(productCategory.productId));
          }
        }

        transaction.delete(productRef);
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  // Get all products from the "Products" collection
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection("Products").get();
      final result =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return result;
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

  Future<List<ProductCategoryModel>> getProductCategories(
      String productId) async {
    try {
      final snapshot = await _db
          .collection("ProductCategory")
          .where("productId", isEqualTo: productId)
          .get();

      final result = snapshot.docs
          .map((doc) => ProductCategoryModel.fromSnapshot(doc))
          .toList();

      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }

  Future<void> removeProductCategory(
      String productId, String categoryId) async {
    try {
      final snapshot = await _db
          .collection("ProductCategory")
          .where("productId", isEqualTo: productId)
          .where("categoryId", isEqualTo: categoryId)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. ${e.toString()}';
    }
  }
}
