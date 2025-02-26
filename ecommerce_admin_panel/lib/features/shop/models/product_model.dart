import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';

import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  String title;
  String? description;
  double price;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  List<String>? images;
  int soldQuantity;
  DateTime? date;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  }); // Default to an empty map if null

  // Helper function to get formatted created date
  String get formattedDate => TFormatter.formatDate(date);

  // Getter to calculate total amount (price * soldQuantity)
  double get totalAmount => price * soldQuantity;

  // Static function to create an empty product model
  static ProductModel empty() => ProductModel(
      id: "", title: "", stock: 0, price: 0, thumbnail: '', productType: '');

  // Convert model to JSON structure for storing data in Firebase or APIs
  toJson() {
    return {
      'SKU': sku,
      // 'id': id,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      "ProductType": productType,
      'SoldQuantity': soldQuantity,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  // Factory method to create a ProductModel from a JSON object
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? "",
      sku: data['SKU'],
      stock: data['Stock'],
      soldQuantity:
          data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      categoryId: data['CategoryId'] ?? "",
      description: data['Description'] ?? "",
      productType: data['ProductType'] ?? "",
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      brand: BrandModel.fromJson(data['Brand']),
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? "",
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      soldQuantity:
          data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      categoryId: data['CategoryId'] ?? "",
      description: data['Description'] ?? "",
      productType: data['ProductType'] ?? "",
      brand: BrandModel.fromJson(data['Brand']),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}
