import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final List<ProductModel> items; // List of ordered products
  final DateTime? deliveryDate;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    this.paymentMethod = 'Paypal',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.items = const [],
    this.deliveryDate,
  });

  // Format order date for display
  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  // Format delivery date for display
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : 'N/A';

  String get formatOrderDateText {
    final now = DateTime.now();
    final difference = now.difference(orderDate);

    String timeAgo;
    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      timeAgo = "$months Month${months > 1 ? 's' : ''} Ago";
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      timeAgo = "$weeks Week${weeks > 1 ? 's' : ''} Ago";
    } else if (difference.inDays >= 1) {
      timeAgo =
          "${difference.inDays} Day${difference.inDays > 1 ? 's' : ''} Ago";
    } else if (difference.inHours >= 1) {
      timeAgo =
          "${difference.inHours} Hour${difference.inHours > 1 ? 's' : ''} Ago";
    } else {
      timeAgo = "Just now";
    }

    return "$timeAgo, #[$id]";
  }

  // Get a human-readable status text
  String get orderStatusText {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.processing:
        return 'Processing';
      default:
        return 'Unknown';
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
      'items': items.map((item) => item.toJson()).toList(),
      'deliveryDate': deliveryDate?.toIso8601String(),
    };
  }

  // static OrderModel empty() => OrderModel(id: "", status: OrderStatus.processing, totalAmount: 0, orderDate: DateTime.now());

  factory OrderModel.fromSnapshot(DocumentSnapshot document) {
    // final id = document.id;
    final data = document.data() as Map<String, dynamic>;
    return OrderModel(
      id: document.id,
      userId: data['userId'] ?? '',
      docId: data['docId'] ?? '',
      status: OrderStatus.values.firstWhere(
        (status) => status.name == data['status'],
        orElse: () => OrderStatus.processing,
      ),
      totalAmount: double.parse((data['totalAmount'] ?? 0.0).toString()),
      orderDate: DateTime.parse(data['orderDate']),
      paymentMethod: data['paymentMethod'] ?? 'Paypal',
      deliveryDate: data['deliveryDate'] != null
          ? DateTime.parse(data['deliveryDate'])
          : null,
      items: (data['items'] as List<dynamic>? ?? [])
          .map((e) => ProductModel.fromSnapshot(e))
          .toList(),
    );
  }
}
