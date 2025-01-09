import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  // Constructor
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    required this.fileName,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
    this.mediaCategory = '',
  });

  // Factory constructor to create an empty ImageModel instance
  static ImageModel empty() => ImageModel(url: '', folder: '', fileName: '');

  // Getter for formatted creation date
  String get createdAtFormatted => TFormatter.formatDate(createdAt);

  // Getter for formatted update date
  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  // Convert ImageModel instance to JSON format for storage in Firestore
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'fileName': fileName,
      'fullPath': fullPath,
      'contentType': contentType,
      'createdAt': createdAt?.toUtc(),
      'mediaCategory': mediaCategory,
    };
  }

  // Deserialize Firestore document snapshot into ImageModel
  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        fileName: data['fileName'] ?? '',
        fullPath: data['fullPath'],
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
        contentType: data['contentType'],
        mediaCategory: data['mediaCategory'] ?? '',
      );
    } else {
      return ImageModel.empty();
    }
  }

  // Map Firebase Storage Data
  factory ImageModel.fromFirebaseMetaData(FullMetadata metaData, String folder,
      String fileName, String downloadUrl) {
    return ImageModel(
        url: downloadUrl,
        folder: folder,
        fileName: fileName,
        sizeBytes: metaData.size,
        updatedAt: metaData.updated,
        fullPath: metaData.fullPath,
        createdAt: metaData.timeCreated,
        contentType: metaData.contentType);
  }
}
