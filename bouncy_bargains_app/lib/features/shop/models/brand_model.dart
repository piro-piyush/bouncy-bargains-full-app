import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String? id;
  String name;
  String image;
  bool isFeatured;
  int productsCount;

  // Constructor
  BrandModel({
    this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productsCount = 0,
  });

  // Factory method to create a BrandModel from Firestore DocumentSnapshot
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount:
            data.containsKey('ProductsCount') ? data['ProductsCount'] ?? 0 : 0,
      );
    } else {
      return BrandModel.empty();
    }
  }

  // Method to convert BrandModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductsCount': productsCount,
    };
  }

  // Empty Brand Helper Function
  static BrandModel empty() {
    return BrandModel(
      id: '',
      name: '',
      image: '',
      isFeatured: false,
      productsCount: 0,
    );
  }

  // fromJson method to create a BrandModel instance from a JSON Map
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? '',
      // Assuming 'id' is passed from the JSON
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
      productsCount: json['ProductsCount'] ?? 0,
    );
  }
}
