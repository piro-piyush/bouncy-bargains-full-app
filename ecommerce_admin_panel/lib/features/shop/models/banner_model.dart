import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String imageUrl;
  final String targetScreen; // Renamed to targetScreen
  final bool active;

  // Constructor
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  // Named constructor for creating an empty BannerModel
  factory BannerModel.empty() {
    return BannerModel(
      imageUrl: '',
      targetScreen: '',
      active: false,
    );
  }

  // Factory constructor to create a BannerModel from a Firestore snapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      imageUrl: data['imageUrl'] ?? '',
      targetScreen: data['targetScreen'] ?? '', // Updated key
      active: data['active'] ?? false,
    );
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
