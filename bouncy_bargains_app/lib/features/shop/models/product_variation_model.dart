import 'package:cloud_firestore/cloud_firestore.dart';

class ProductVariationModel {
  String id;
  int stock;
  int price;
  double salePrice;
  String image;
  String description;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.salePrice,
    required this.image,
    required this.description,
    required this.attributeValues,
  });

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'],
      stock: json['stock'],
      price: json['price'],
      salePrice: json['salePrice'],
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      attributeValues: Map<String, String>.from(json['attributeValues'] ?? {}),
    );
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
    return ProductVariationModel(
      id: '',
      stock: 0,
      price: 0,
      salePrice: 0,
      image: '',
      description: '',
      attributeValues: {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stock': stock,
      'price': price,
      'salePrice': salePrice,
      'image': image,
      'description': description,
      'attributeValues': attributeValues,
    };
  }
}
