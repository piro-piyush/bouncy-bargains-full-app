import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
    this.appName = "",
    this.appLogo = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingThreshold': freeShippingThreshold,
      'appName': appName,
      'appLogo': appLogo,
    };
  }
  static double toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static SettingsModel empty() => SettingsModel();

  factory SettingsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data();
      return SettingsModel(
        id: snapshot.id,
        taxRate: toDouble(data?['taxRate']),
        shippingCost: toDouble(data?['shippingCost']),
        freeShippingThreshold: toDouble(data?['freeShippingThreshold']),
        appName: data?['appName'] ?? '',
        appLogo: data?['appLogo'] ?? '',
      );
    } else {
      return SettingsModel.empty();
    }
  }



}
