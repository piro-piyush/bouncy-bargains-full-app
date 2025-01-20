import 'package:bouncy_bargain/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:bouncy_bargain/features/shop/models/banner_model.dart';
import 'package:bouncy_bargain/utils/dummy/dummy_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/format_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/platform_exceptions.dart';

class BannerRepositories extends GetxController {
  // Singleton pattern to access the instance of BannerRepositories
  static BannerRepositories get instance => Get.find();

  // Firestore database instance for interacting with Firestore
  final _db = FirebaseFirestore.instance;

  // Fetch all active banners from the Firestore database
  Future<List<BannerModel>> fetchBanners() async {
    try {
      // Get the banners collection from Firestore
      final result = await _db
          .collection("Banners")
          .where("active", isEqualTo: true) // Filter for active banners
          .get();

      // Map the documents from Firestore to BannerModel and return as a list
      final list = result.docs
          .map((document) => BannerModel.fromSnapshot(document))
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
      throw 'Something went wrong while fetching Banners.';
    }
  }

  // Upload dummy data to Firestore including image links
  Future<void> uploadDummyData() async {
    try {
      // Get instance of FirebaseStorageService to manage image uploads
      final storage = Get.put(XFirebaseStorageService());

      // Loop through each banner in the dummy data
      for (int i = 0; i < XDummyData.banners.length; i++) {
        // Get the current banner data
        var banner = XDummyData.banners[i];

        // Get image data from local assets
        final file = await storage.getImageDataFromAssets(banner.imageUrl);

        // Upload the image to Firebase Storage and get the URL
        final url =
            await storage.uploadImageData('Banners', file, i.toString());

        // Update the banner's image URL with the URL from Firebase Storage
        banner.imageUrl = url;

        // Save the updated banner to Firestore
        await _db.collection("Banners").doc().set(banner.toJson());
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication exceptions
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      // Handle Firebase exceptions
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Handle format exceptions
      throw const XFormatException();
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions
      throw XPlatformException(e.code).message;
    } catch (e) {
      // Handle any other errors during the upload process
      throw 'Something went wrong. Please try again.';
    }
  }
}
