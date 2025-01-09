import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload any Image using File
  Future<ImageModel> uploadImageFileInStorage(
      {required html.File file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');

      // Uploaded File
      await ref.putBlob(file);

      // Get download Url
      final String downloadUrl = await ref.getDownloadURL();

      // Fetch MetaData
      final FullMetadata metadata = await ref.getMetadata();
      return ImageModel.fromFirebaseMetaData(
          metadata, path, imageName, downloadUrl);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Upload Image data
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
