import 'package:bouncy_bargain/features/shop/models/product_model.dart';
import 'package:bouncy_bargain/utils/constants/enums.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final List<ProductModel>? items; // List of ordered products
  final DateTime? deliveryDate;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    this.paymentMethod = 'Paypal',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.items,
    this.deliveryDate,
  });

  // Format order date for display
  String get formattedOrderDate => XHelperFunctions.getFormattedDate(orderDate);

  // Format delivery date for display
  String get formattedDeliveryDate => deliveryDate != null
      ? XHelperFunctions.getFormattedDate(deliveryDate!)
      : 'N/A';

  // Get a human-readable status text
  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.processing:
        return 'Processing';
      }
  }

  // Convert model to JSON for Firestore or API usage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'docId': docId,
      'status': status.name,
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'items': items?.map((item) => item.toJson()).toList(),
      'deliveryDate': deliveryDate?.toIso8601String(),
    };
  }

  // Factory constructor to create an OrderModel from JSON data
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['userId'] ?? '',
      docId: json['docId'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'Paypal',
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.processing,
      ),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      items: json['items'] != null
          ? (json['items'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList()
          : null,
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
    );
  }

}
