import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
  });

  // Empty Helper Function
  static CategoryModel empty() => CategoryModel(
      id: '', name: '', image: '', parentId: '', isFeatured: false);

  // Convert model to JSON structure so that you can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  // Map Json oriented docuement snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> docuement) {
    if (docuement.data() != null) {
      final data = docuement.data()!;

      // Map Json record to the model
      return CategoryModel(
        id: docuement.id,
        name: data['Name'] ?? "",
        image: data['Image'] ?? "",
        parentId: data['ParentId'] ?? "",
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
