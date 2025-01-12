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
  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  // Format delivery date for display
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
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

  static List<OrderModel> sampleOrders = [
    OrderModel(
      id: 'order1',
      userId: 'user3',
      docId: 'doc45',
      status: OrderStatus.processing,
      totalAmount: 79.99,
      orderDate: DateTime(2025, 1, 12),
      paymentMethod: 'Credit Card',
      items: [
        ProductModel(
          id: '1',
          name: 'Product 35',
          description: 'A great product with features 23',
          category: 'Electronics',
          price: 39.99,
          quantity: 1,
          imageUrl: 'assets/icons/brands/nike.png',
          createdAt: DateTime.now().subtract(Duration(days: 3)),
          updatedAt: DateTime.now().subtract(Duration(days: 2)),
          selectedVariation: {'Color': 'Red', 'Size': 'Medium'},
        ),
        ProductModel(
          id: '2',
          name: 'Product 82',
          description: 'A great product with features 56',
          category: 'Home',
          price: 29.99,
          quantity: 1,
          imageUrl: 'assets/icons/brands/adidas-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 10)),
          updatedAt: DateTime.now().subtract(Duration(days: 5)),
          selectedVariation: {'Color': 'Blue', 'Size': 'Large'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 15),
    ),
    OrderModel(
      id: 'order2',
      userId: 'user1',
      docId: 'doc38',
      status: OrderStatus.shipped,
      totalAmount: 45.50,
      orderDate: DateTime(2025, 1, 10),
      paymentMethod: 'Paypal',
      items: [
        ProductModel(
          id: '3',
          name: 'Product 12',
          description: 'A great product with features 11',
          category: 'Fashion',
          price: 22.75,
          quantity: 1,
          imageUrl: 'assets/icons/brands/apple-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 5)),
          updatedAt: DateTime.now().subtract(Duration(days: 3)),
          selectedVariation: {'Color': 'Green', 'Size': 'Small'},
        ),
        ProductModel(
          id: '4',
          name: 'Product 65',
          description: 'A great product with features 48',
          category: 'Fashion',
          price: 22.75,
          quantity: 1,
          imageUrl: 'assets/icons/brands/jordan-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 8)),
          updatedAt: DateTime.now().subtract(Duration(days: 2)),
          selectedVariation: {'Color': 'Black', 'Size': 'Medium'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 14),
    ),
    OrderModel(
      id: 'order3',
      userId: 'user8',
      docId: 'doc99',
      status: OrderStatus.delivered,
      totalAmount: 120.40,
      orderDate: DateTime(2025, 1, 5),
      paymentMethod: 'Debit Card',
      items: [
        ProductModel(
          id: '5',
          name: 'Product 87',
          description: 'A great product with features 77',
          category: 'Electronics',
          price: 60.20,
          quantity: 1,
          imageUrl: 'assets/icons/brands/puma-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 7)),
          updatedAt: DateTime.now().subtract(Duration(days: 3)),
          selectedVariation: {'Color': 'Black', 'Size': 'Medium'},
        ),
        ProductModel(
          id: '6',
          name: 'Product 29',
          description: 'A great product with features 55',
          category: 'Home',
          price: 60.20,
          quantity: 1,
          imageUrl: 'assets/icons/brands/zara-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 10)),
          updatedAt: DateTime.now().subtract(Duration(days: 4)),
          selectedVariation: {'Color': 'White', 'Size': 'Large'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 7),
    ),
    OrderModel(
      id: 'order4',
      userId: 'user2',
      docId: 'doc72',
      status: OrderStatus.processing,
      totalAmount: 66.60,
      orderDate: DateTime(2025, 1, 2),
      paymentMethod: 'Paypal',
      items: [
        ProductModel(
          id: '7',
          name: 'Product 48',
          description: 'A great product with features 38',
          category: 'Toys',
          price: 33.30,
          quantity: 2,
          imageUrl: 'assets/icons/brands/kenwood-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 2)),
          updatedAt: DateTime.now().subtract(Duration(days: 1)),
          selectedVariation: {'Color': 'Yellow', 'Size': 'Small'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 10),
    ),
    OrderModel(
      id: 'order5',
      userId: 'user6',
      docId: 'doc31',
      status: OrderStatus.shipped,
      totalAmount: 158.70,
      orderDate: DateTime(2025, 1, 3),
      paymentMethod: 'Credit Card',
      items: [
        ProductModel(
          id: '8',
          name: 'Product 64',
          description: 'A great product with features 15',
          category: 'Home',
          price: 79.35,
          quantity: 2,
          imageUrl: 'assets/icons/brands/herman-miller-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 10)),
          updatedAt: DateTime.now().subtract(Duration(days: 3)),
          selectedVariation: {'Color': 'Blue', 'Size': 'Medium'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 12),
    ),
    OrderModel(
      id: 'order6',
      userId: 'user5',
      docId: 'doc21',
      status: OrderStatus.delivered,
      totalAmount: 190.85,
      orderDate: DateTime(2025, 1, 7),
      paymentMethod: 'Debit Card',
      items: [
        ProductModel(
          id: '9',
          name: 'Product 56',
          description: 'A great product with features 99',
          category: 'Books',
          price: 95.43,
          quantity: 2,
          imageUrl: 'assets/icons/brands/ikea_logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 5)),
          updatedAt: DateTime.now().subtract(Duration(days: 1)),
          selectedVariation: {'Color': 'Red', 'Size': 'Small'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 10),
    ),
    OrderModel(
      id: 'order7',
      userId: 'user4',
      docId: 'doc10',
      status: OrderStatus.processing,
      totalAmount: 135.60,
      orderDate: DateTime(2025, 1, 4),
      paymentMethod: 'Paypal',
      items: [
        ProductModel(
          id: '10',
          name: 'Product 72',
          description: 'A great product with features 24',
          category: 'Electronics',
          price: 67.80,
          quantity: 2,
          imageUrl: 'assets/icons/brands/acer_logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 8)),
          updatedAt: DateTime.now().subtract(Duration(days: 4)),
          selectedVariation: {'Color': 'Green', 'Size': 'Large'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 9),
    ),
    OrderModel(
      id: 'order8',
      userId: 'user7',
      docId: 'doc13',
      status: OrderStatus.shipped,
      totalAmount: 83.90,
      orderDate: DateTime(2025, 1, 6),
      paymentMethod: 'Cash on Delivery',
      items: [
        ProductModel(
          id: '11',
          name: 'Product 33',
          description: 'A great product with features 12',
          category: 'Books',
          price: 41.95,
          quantity: 2,
          imageUrl: 'assets/icons/brands/nike.png',
          createdAt: DateTime.now().subtract(Duration(days: 3)),
          updatedAt: DateTime.now().subtract(Duration(days: 1)),
          selectedVariation: {'Color': 'Yellow', 'Size': 'Medium'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 13),
    ),
    OrderModel(
      id: 'order9',
      userId: 'user3',
      docId: 'doc77',
      status: OrderStatus.processing,
      totalAmount: 99.50,
      orderDate: DateTime(2025, 1, 8),
      paymentMethod: 'Credit Card',
      items: [
        ProductModel(
          id: '12',
          name: 'Product 79',
          description: 'A great product with features 56',
          category: 'Sports',
          price: 49.75,
          quantity: 2,
          imageUrl: 'assets/icons/brands/adidas-logo.png',
          createdAt: DateTime.now().subtract(Duration(days: 5)),
          updatedAt: DateTime.now().subtract(Duration(days: 2)),
          selectedVariation: {'Color': 'Red', 'Size': 'Large'},
        ),
      ],
      deliveryDate: DateTime(2025, 1, 17),
    ),
  ];
}
