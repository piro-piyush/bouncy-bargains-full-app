import 'package:cloud_firestore/cloud_firestore.dart';

class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values'] ?? []),
    );
  }

  factory ProductAttributeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductAttributeModel(
        name: data['Name'],
        values: List<String>.from(data['Values'] ?? []),
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
      'Name': name,
      'Values': values,
    };
  }
}
