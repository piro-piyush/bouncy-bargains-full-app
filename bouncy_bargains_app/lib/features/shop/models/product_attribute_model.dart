import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAttributeModel {
  String name;
  List<String> values;

  ProductAttributeModel({
    required this.name,
    required this.values,
  });

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'],
      values: List<String>.from(json['values'] ?? []),
    );
  }

  factory ProductAttributeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductAttributeModel(
        name: data['name'],
        values: List<String>.from(data['values'] ?? []),
      );
    } else {
      return ProductAttributeModel.empty();
    }
  }

  static ProductAttributeModel empty() {
    return ProductAttributeModel(
      name: '',
      values: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }
}
