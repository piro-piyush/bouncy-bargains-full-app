import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';

class ProductModel {
  final String? id;
  String name;
  String description;
  String category;
  double price;
  int stockQuantity;
  String imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor for product model
  ProductModel({
    this.id,
    required this.name,
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.stockQuantity = 0,
    this.imageUrl = '',
    this.createdAt,
    this.updatedAt,
  });

  // Helper function to get formatted created date
  String get formattedDate => TFormatter.formatDate(createdAt);

  // Helper function to get formatted updated date
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  // Static function to create an empty product model
  static ProductModel empty() => ProductModel(name: '');

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Description': description,
      'Category': category,
      'Price': price,
      'StockQuantity': stockQuantity,
      'ImageUrl': imageUrl,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  // Factory method to create a ProductModel from a Firebase document snapshot
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        name: data.containsKey('Name') ? data['Name'] ?? '' : '',
        description: data.containsKey('Description') ? data['Description'] ?? '' : '',
        category: data.containsKey('Category') ? data['Category'] ?? '' : '',
        price: data.containsKey('Price') ? (data['Price'] ?? 0.0).toDouble() : 0.0,
        stockQuantity: data.containsKey('StockQuantity') ? (data['StockQuantity'] ?? 0) : 0,
        imageUrl: data.containsKey('ImageUrl') ? data['ImageUrl'] ?? '' : '',
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
