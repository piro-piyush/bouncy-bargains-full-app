import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  int stock;
  int soldQuantity;
  double price;
  double salePrice;
  String description;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    this.description = '',
    required this.attributeValues,
  }) : image = image.obs;

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['Id'] ?? "",
        stock: data['stock'] ?? 0,
        price: double.parse((data['Price'] ?? 0.0).toString()),
        sku: data['SKU'] ?? '',
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        soldQuantity: data['soldQuantity'] ?? 0,
        image: data['Image'] ?? '',
        description: data['Description'] ?? '',
        attributeValues: Map<String, String>.from(data['attributeValues']));
  }

  factory ProductVariationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductVariationModel(
        id: data['id'],
        stock: data['stock'],
        price: data['price'],
        salePrice: data['salePrice'],
        image: data['image'] ?? '',
        description: data['description'] ?? '',
        attributeValues:
            Map<String, String>.from(data['attributeValues'] ?? {}),
      );
    } else {
      return ProductVariationModel.empty();
    }
  }

  static ProductVariationModel empty() {
    return ProductVariationModel(id: '', attributeValues: {});
  }

  /// Json Format
  toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'SoldQuantity': soldQuantity,
      'Image': image.value,
      'Description': description,
      'AttributeValues': attributeValues,
    };
  }
}
