import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = "",
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  // Empty Helper Function
  static CategoryModel empty() =>
      CategoryModel(id: "", name: "", image: "", isFeatured: false);

  // Factory method to create a CategoryModel from Firestore DocumentSnapshot
  factory CategoryModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createdAt:
            data.containsKey("CreatedAt") ? data["CreatedAt"]?.toDate() : null,
        updatedAt:
            data.containsKey("UpdatedAt") ? data["UpdatedAt"]?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }

  // Method to convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
      // Assigning DateTime.now() only if updatedAt is null
    };
  }

  // toString method to print all data
  @override
  String toString() {
    return '''
    CategoryModel(
      id: $id,
      name: $name,
      image: $image,
      parentId: $parentId,
      isFeatured: $isFeatured,
      createdAt: ${createdAt?.toIso8601String()},
      updatedAt: ${updatedAt?.toIso8601String()}
    )''';
  }
}
