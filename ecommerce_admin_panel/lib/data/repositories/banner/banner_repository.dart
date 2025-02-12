import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all banner from the "Banners" collection
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection("Banners").get();
      final result =
          snapshot.docs.map((doc) => BannerModel.fromSnapshot(doc)).toList();
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

  // Create a new banner in Firestore
  Future<String> createBanner({required BannerModel banner}) async {
    try {
      final result = await _db.collection("Banners").add(banner.toJson());
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

  // Update a  banner in Firestore
  Future<void> updateBanner({required BannerModel banner}) async {
    try {
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
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

  // Delete a banner from Firestore
  Future<void> deleteBanner({required String bannerId}) async {
    try {
      await _db.collection("Banners").doc(bannerId).delete();
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
}
