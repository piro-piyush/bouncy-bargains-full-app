import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

// List of sample orders
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'order1',
      userId: 'user1',
      docId: 'doc1',
      status: OrderStatus.processing,
      totalAmount: 100.0,
      orderDate: DateTime.now(),
      paymentMethod: 'Credit Card',
      items: [
        ProductModel(
          id: 'product1',
          name: 'Product 1',
          description: 'Description of Product 1',
          category: 'Category 1',
          price: 20.0,
          quantity: 2,
          imageUrl: 'http://example.com/product1.jpg',
          selectedVariation: {'Size': 'M', 'Color': 'Red'},
        ),
        ProductModel(
          id: 'product2',
          name: 'Product 2',
          description: 'Description of Product 2',
          category: 'Category 2',
          price: 60.0,
          quantity: 1,
          imageUrl: 'http://example.com/product2.jpg',
          selectedVariation: {'Size': 'L', 'Color': 'Blue'},
        ),
      ],
      deliveryDate: DateTime.now().add(Duration(days: 5)),
    ),
    OrderModel(
      id: 'order2',
      userId: 'user2',
      docId: 'doc2',
      status: OrderStatus.shipped,
      totalAmount: 150.0,
      orderDate: DateTime.now().subtract(Duration(days: 2)),
      paymentMethod: 'Paypal',
      items: [
        ProductModel(
          id: 'product3',
          name: 'Product 3',
          description: 'Description of Product 3',
          category: 'Category 3',
          price: 40.0,
          quantity: 2,
          imageUrl: 'http://example.com/product3.jpg',
          selectedVariation: {'Size': 'XL', 'Color': 'Green'},
        ),
        ProductModel(
          id: 'product4',
          name: 'Product 4',
          description: 'Description of Product 4',
          category: 'Category 4',
          price: 70.0,
          quantity: 1,
          imageUrl: 'http://example.com/product4.jpg',
          selectedVariation: {'Size': 'S', 'Color': 'Black'},
        ),
      ],
      deliveryDate: DateTime.now().add(Duration(days: 7)),
    ),
  ];

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // Calculate weekly Sales
  void _calculateWeeklySales() {
    // Reset weekly sales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);
    for (var order in orders) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is not negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
        print(
            'OrderDate : ${order.orderDate}, CurrencyWeekDay : $orderWeekStart, Index : $index');
      }
    }
    print('Weekly sales: $weeklySales');
  }

  // Call this function to calculate Order Status counts
  void _calculateOrderStatusData() {
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      // Count orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Calculate total amounts for each status
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }
}
