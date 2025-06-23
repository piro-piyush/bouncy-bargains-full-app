import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// 🛒 `OrderRepository`
///
/// Manages all Firestore operations related to Orders:
/// - Fetch all orders
/// - Fetch a specific order
/// - Delete orders
/// - Update specific fields in an order
///
/// Uses custom exception classes for consistent error messaging.
class OrderRepository extends GetxController {
  /// Singleton instance for DI via `GetX`
  static OrderRepository get instance => Get.find();

  /// Firestore instance reference
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ──────────────────────────────────────────────────────────────
  /// 🔍 Fetches all orders from Firestore.
  ///
  /// Returns a `List<OrderModel>` of all existing orders.
  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final querySnapshot = await _db.collection("Orders").get();
      return querySnapshot.docs.map(OrderModel.fromSnapshot).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("🔥 Error fetching all orders: $e");
      throw 'Something went wrong while fetching orders: $e';
    }
  }

  // ──────────────────────────────────────────────────────────────
  /// 🔍 Fetches a specific order by its `docId`.
  ///
  /// Returns a `List<OrderModel>` (typically one item, based on filtering).
  Future<List<OrderModel>> fetchOrder(String docId) async {
    try {
      final querySnapshot = await _db
          .collection("Orders")
          .where("docId", isEqualTo: docId)
          .get();

      return querySnapshot.docs.map(OrderModel.fromSnapshot).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("🚨 Error fetching order: $e");
      throw 'Something went wrong while fetching the order: $e';
    }
  }

  // ──────────────────────────────────────────────────────────────
  /// 🧹 Deletes all orders with matching `docId`.
  ///
  /// ⚠️ This permanently deletes all matching orders.
  Future<void> deleteUserOrders(String docId) async {
    try {
      final querySnapshot = await _db
          .collection("Orders")
          .where("docId", isEqualTo: docId)
          .get();

      for (final doc in querySnapshot.docs) {
        await _db.collection("Orders").doc(doc.id).delete();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("💥 Error deleting orders: $e");
      throw 'Something went wrong while deleting orders: $e';
    }
  }

  // ──────────────────────────────────────────────────────────────
  /// ✏️ Updates specific fields in an order using `docId`.
  ///
  /// Accepts a map of key-value fields to update, like: `{ 'status': 'delivered' }`
  Future<void> updateOrderSpecificValue(
      String docId,
      Map<String, dynamic> data,
      ) async {
    try {
      final querySnapshot = await _db
          .collection("Orders")
          .where("docId", isEqualTo: docId)
          .get();

      for (final doc in querySnapshot.docs) {
        await _db.collection("Orders").doc(doc.id).update(data);
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("🛠️ Error updating order: $e");
      throw 'Something went wrong while updating the order: $e';
    }
  }
}
