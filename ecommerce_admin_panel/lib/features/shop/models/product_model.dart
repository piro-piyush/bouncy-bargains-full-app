import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';

class ProductModel {
  final String? id;
  String name;
  String description;
  String category;
  double price;
  int quantity;
  String imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Map<String, String> selectedVariation; // Non-nullable map for variations

  ProductModel({
    this.id,
    required this.name,
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.quantity = 0,
    this.imageUrl = '',
    this.createdAt,
    this.updatedAt,
    Map<String, String>? selectedVariation, // Optional parameter
  }) : selectedVariation =
            selectedVariation ?? {}; // Default to an empty map if null

  // Helper function to get formatted created date
  String get formattedDate => TFormatter.formatDate(createdAt);

  // Helper function to get formatted updated date
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  // Getter to calculate total amount (price * quantity)
  double get totalAmount => price * quantity;

  // Static function to create an empty product model
  static ProductModel empty() => ProductModel(name: '');

  // Convert model to JSON structure for storing data in Firebase or APIs
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Description': description,
      'Category': category,
      'Price': price,
      'Quantity': quantity,
      'ImageUrl': imageUrl,
      'CreatedAt': createdAt?.toIso8601String(),
      'UpdatedAt':
          updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'SelectedVariation': selectedVariation, // Serialize variations
      'TotalAmount': totalAmount, // Add totalAmount to the JSON output
    };
  }

  // Factory method to create a ProductModel from a JSON object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      category: json['Category'] ?? '',
      price: (json['Price'] ?? 0.0).toDouble(),
      quantity: json['Quantity'] ?? 0,
      imageUrl: json['ImageUrl'] ?? '',
      createdAt:
          json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : null,
      updatedAt:
          json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      selectedVariation: json['SelectedVariation'] != null
          ? Map<String, String>.from(json['SelectedVariation'])
          : {}, // Default to an empty map if null
    );
  }
}
