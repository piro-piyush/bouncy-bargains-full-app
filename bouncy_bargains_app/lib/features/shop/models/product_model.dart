import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bouncy_bargain/features/shop/models/brand_model.dart';
import 'package:bouncy_bargain/features/shop/models/product_attribute_model.dart';
import 'package:bouncy_bargain/features/shop/models/product_variation_model.dart';
import 'package:bouncy_bargain/utils/formatters/formatter.dart';

class ProductModel {
  final String? id;
  String title;
  int stock;
  double price;
  int salePrice;
  bool isFeatured;
  String thumbnail;
  String description;
  BrandModel brand;
  List<String> images;
  String sku;
  int quantity;
  String categoryId;
  String productType;
  List<ProductAttributeModel> productAttributes;
  List<ProductVariationModel> productVariations;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.title,
    required this.stock,
    required this.isFeatured,
    required this.thumbnail,
    required this.brand,
    required this.images,
    required this.salePrice,
    required this.sku,
    required this.categoryId,
    required this.productAttributes,
    required this.productType,
    this.description = '',
    this.price = 0.0,
    this.quantity = 0,
    this.createdAt,
    this.updatedAt,
    this.productVariations = const [],
  });

  // Helper function to get formatted created date using TFormatter
  String get formattedDate => XFormatter.formatDate(createdAt);

  // Helper function to get formatted updated date using TFormatter
  String get formattedUpdatedDate => XFormatter.formatDate(updatedAt);

  // Getter to calculate total amount (price * quantity)
  double get totalAmount => price * quantity;

  // Static function to create an empty product model
  static ProductModel empty() => ProductModel(
        title: '',
        stock: 0,
        isFeatured: false,
        thumbnail: '',
        brand: BrandModel.empty(),
        images: [],
        salePrice: 0,
        sku: '',
        categoryId: '',
        productAttributes: [],
        productType: '',
      );

  // Convert model to JSON structure for storing data in Firebase or APIs
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Title': title,
      'Description': description,
      'Price': price,
      'Quantity': quantity,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
      'Stock': stock,
      'IsFeatured': isFeatured,
      'Thumbnail': thumbnail,
      'Brand': brand.toJson(),
      'Images': images,
      'SalePrice': salePrice,
      'Sku': sku,
      'CategoryId': categoryId,
      'Attributes':
          productAttributes.map((attribute) => attribute.toJson()).toList(),
      'ProductType': productType,
      'TotalAmount': totalAmount,
    };
  }

  // Factory method to create a ProductModel from a JSON object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['Title'] ?? '',
      description: json['Description'] ?? '',
      price: (json['Price'] ?? 0.0).toDouble(),
      quantity: json['Quantity'] ?? 0,
      createdAt:
          json['CreatedAt'] != null ? DateTime.parse(json['CreatedAt']) : null,
      updatedAt:
          json['UpdatedAt'] != null ? DateTime.parse(json['UpdatedAt']) : null,
      stock: json['Stock'] ?? 0,
      isFeatured: json['IsFeatured'] ?? false,
      thumbnail: json['Thumbnail'] ?? '',
      brand: BrandModel.fromJson(json['Brand']),
      images: List<String>.from(json['Images'] ?? []),
      salePrice: json['SalePrice'] ?? 0,
      sku: json['Sku'] ?? '',
      categoryId: json['CategoryId'] ?? '',
      productAttributes: List<ProductAttributeModel>.from(
        json['Attributes']?.map((x) => ProductAttributeModel.fromJson(x)) ?? [],
      ),
      productType: json['ProductType'] ?? '',
      productVariations: List<ProductVariationModel>.from(
        json['ProductVariations']
                ?.map((x) => ProductVariationModel.fromJson(x)) ??
            [],
      ),
    );
  }

  // Factory method to create a ProductModel from a Firestore snapshot
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
        id: document.id,
        title: data['Title'] ?? '',
        description: data['Description'] ?? '',
        price: (data['Price'] ?? 0.0).toDouble(),
        quantity: data['Quantity'] ?? 0,
        createdAt:
            data.containsKey("CreatedAt") ? data["CreatedAt"]?.toDate() : null,
        updatedAt:
            data.containsKey("UpdatedAt") ? data["UpdatedAt"]?.toDate() : null,
        stock: data['Stock'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
        thumbnail: data['Thumbnail'] ?? '',
        brand: BrandModel.fromJson(data['Brand']),
        images: List<String>.from(data['Images'] ?? []),
        salePrice: data['SalePrice'] ?? 0,
        sku: data['Sku'] ?? '',
        categoryId: data['CategoryId'] ?? '',
        productAttributes: List<ProductAttributeModel>.from(
          data['Attributes']?.map((x) => ProductAttributeModel.fromJson(x)) ??
              [],
        ),
        productType: data['ProductType'] ?? '',
        productVariations: List<ProductVariationModel>.from(
          data['ProductVariations']
                  ?.map((x) => ProductVariationModel.fromJson(x)) ??
              [],
        ),
      );
    } else {
      return ProductModel.empty();
    }
  }
}
