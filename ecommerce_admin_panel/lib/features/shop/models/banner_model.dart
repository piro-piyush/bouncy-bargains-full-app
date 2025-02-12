import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
   String imageUrl;
   String targetScreen;
   bool active;

  // Constructor
  BannerModel({
    this.id,
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

  /// Method for formatting a route string.
  String formatRoute() {
    if (targetScreen.isEmpty) return "";
    // Remove the leading "/"
    String formatted = targetScreen.substring(1);
    // Capitalize the first character
    formatted = formatted[0].toUpperCase() + formatted.substring(1);
    return formatted;
  }

  // Factory constructor to create a BannerModel from a Firestore snapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id:snapshot.id,
      imageUrl: data['imageUrl'] ?? '',
      targetScreen: data['targetScreen'] ?? '',
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
