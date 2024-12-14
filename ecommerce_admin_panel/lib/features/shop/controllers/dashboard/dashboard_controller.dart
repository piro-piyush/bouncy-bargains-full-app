import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  // order
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2024, 12, 9),
      // Monday
      deliveryDate: DateTime(2024, 12, 9),
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime(2024, 12, 10),
      // Tuesday
      deliveryDate: DateTime(2024, 12, 10),
    ),
    OrderModel(
      id: 'CWT0152',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime(2024, 12, 11),
      // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime(2024, 12, 12),
      // Thursday
      deliveryDate: DateTime(2024, 12, 12),
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime(2024, 12, 13),
      // Friday
      deliveryDate: DateTime(2024, 12, 13),
    ),
    OrderModel(
      id: 'CWT1537',
      status: OrderStatus.delivered,
      totalAmount: 490,
      orderDate: DateTime(2024, 12, 9),
      // Monday
      deliveryDate: DateTime(2024, 12, 9),
    ),
    OrderModel(
      id: 'CWT1538',
      status: OrderStatus.processing,
      totalAmount: 185,
      orderDate: DateTime(2024, 12, 10),
      // Tuesday
      deliveryDate: DateTime(2024, 12, 10),
    ),
    OrderModel(
      id: 'CWT1539',
      status: OrderStatus.delivered,
      totalAmount: 200,
      orderDate: DateTime(2024, 12, 11),
      // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
    ),
    OrderModel(
      id: 'CWT1540',
      status: OrderStatus.shipped,
      totalAmount: 175,
      orderDate: DateTime(2024, 12, 12),
      // Thursday
      deliveryDate: DateTime(2024, 12, 12),
    ),
    OrderModel(
      id: 'CWT1541',
      status: OrderStatus.processing,
      totalAmount: 320,
      orderDate: DateTime(2024, 12, 13),
      // Friday
      deliveryDate: DateTime(2024, 12, 13),
    ),
    OrderModel(
      id: 'CWT1542',
      status: OrderStatus.delivered,
      totalAmount: 150,
      orderDate: DateTime(2024, 12, 14),
      // Saturday
      deliveryDate: DateTime(2024, 12, 14),
    ),
    OrderModel(
      id: 'CWT1543',
      status: OrderStatus.delivered,
      totalAmount: 230,
      orderDate: DateTime(2024, 12, 15),
      // Sunday
      deliveryDate: DateTime(2024, 12, 15),
    ),
    OrderModel(
      id: 'CWT1544',
      status: OrderStatus.processing,
      totalAmount: 125,
      orderDate: DateTime(2024, 12, 11),
      // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
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
      default:
        return "Unknown";
    }
  }
}
