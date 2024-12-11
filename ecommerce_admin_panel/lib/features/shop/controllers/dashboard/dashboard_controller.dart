import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  // order
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2024, 12, 9), // Monday
      deliveryDate: DateTime(2024, 12, 9),
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 369,
      orderDate: DateTime(2024, 12, 10), // Tuesday
      deliveryDate: DateTime(2024, 12, 10),
    ),
    OrderModel(
      id: 'CWT0152',
      status: OrderStatus.delivered,
      totalAmount: 254,
      orderDate: DateTime(2024, 12, 11), // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
    ),
    OrderModel(
      id: 'CWT0265',
      status: OrderStatus.delivered,
      totalAmount: 355,
      orderDate: DateTime(2024, 12, 12), // Thursday
      deliveryDate: DateTime(2024, 12, 12),
    ),
    OrderModel(
      id: 'CWT1536',
      status: OrderStatus.delivered,
      totalAmount: 115,
      orderDate: DateTime(2024, 12, 13), // Friday
      deliveryDate: DateTime(2024, 12, 13),
    ),
    OrderModel(
      id: 'CWT1537',
      status: OrderStatus.delivered,
      totalAmount: 490,
      orderDate: DateTime(2024, 12, 9), // Monday
      deliveryDate: DateTime(2024, 12, 9),
    ),
    OrderModel(
      id: 'CWT1538',
      status: OrderStatus.processing,
      totalAmount: 185,
      orderDate: DateTime(2024, 12, 10), // Tuesday
      deliveryDate: DateTime(2024, 12, 10),
    ),
    OrderModel(
      id: 'CWT1539',
      status: OrderStatus.delivered,
      totalAmount: 200,
      orderDate: DateTime(2024, 12, 11), // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
    ),
    OrderModel(
      id: 'CWT1540',
      status: OrderStatus.shipped,
      totalAmount: 175,
      orderDate: DateTime(2024, 12, 12), // Thursday
      deliveryDate: DateTime(2024, 12, 12),
    ),
    OrderModel(
      id: 'CWT1541',
      status: OrderStatus.processing,
      totalAmount: 320,
      orderDate: DateTime(2024, 12, 13), // Friday
      deliveryDate: DateTime(2024, 12, 13),
    ),
    OrderModel(
      id: 'CWT1542',
      status: OrderStatus.delivered,
      totalAmount: 150,
      orderDate: DateTime(2024, 12, 14), // Saturday
      deliveryDate: DateTime(2024, 12, 14),
    ),
    OrderModel(
      id: 'CWT1543',
      status: OrderStatus.delivered,
      totalAmount: 230,
      orderDate: DateTime(2024, 12, 15), // Sunday
      deliveryDate: DateTime(2024, 12, 15),
    ),
    OrderModel(
      id: 'CWT1544',
      status: OrderStatus.processing,
      totalAmount: 125,
      orderDate: DateTime(2024, 12, 11), // Wednesday
      deliveryDate: DateTime(2024, 12, 11),
    ),
  ];


  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

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
}
