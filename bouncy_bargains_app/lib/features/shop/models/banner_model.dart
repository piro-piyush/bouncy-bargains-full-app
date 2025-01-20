import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  String targetScreen;
  bool active;

  // Constructor
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Named constructor for creating an empty BannerModel
  static BannerModel empty() {
    return BannerModel(
      imageUrl: '',
      targetScreen: '',
      active: false,
    );
  }

  // Factory constructor to create a BannerModel from a Firestore snapshot
  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists && document.data() != null) {
      final data = document.data()!;
      return BannerModel(
        imageUrl: data['imageUrl'] ?? '',
        // Ensure there's a fallback for null values
        targetScreen: data['targetScreen'] ?? '',
        // Updated key
        active: data['active'] ?? false,
      );
    } else {
      return BannerModel.empty();
    }
  }

  // Method to convert the model to a JSON object for Firestore
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen, // Updated key
      'active': active,
    };
  }

  // Override toString for debugging purposes
  @override
  String toString() {
    return 'BannerModel(imageUrl: $imageUrl, targetScreen: $targetScreen, active: $active)';
  }
}
