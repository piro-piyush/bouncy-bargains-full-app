import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// 📊 DashboardController
/// - Manages data & logic for the Admin Dashboard
/// - Calculates sales, order status stats, and customer growth
/// - Supports weekly and monthly metrics
class DashboardController extends TBaseController<OrderModel> {
  // Singleton Accessor
  static DashboardController get instance => Get.find();

  /// 🔁 External controllers for shared data
  final orderController = OrderController.instance;
  final customerController = CustomerController.instance;

  /// 📈 Weekly sales data (indexed Mon–Sun)
  final RxList<double> weeklySales = <double>[].obs;

  /// 📊 Number of orders grouped by order status
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;

  /// 💵 Total revenue grouped by order status
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  /// 🚀 Fetch data & calculate dashboard statistics
  @override
  Future<List<OrderModel>> fetchItems() async {
    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    if (customerController.allItems.isEmpty) {
      await customerController.fetchItems();
    }

    _calculateWeeklySales();
    _calculateOrderStatusData();

    return orderController.allItems;
  }

  /// 📅 Calculate weekly sales from order data
  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0); // Reset sales list

    for (var order in orderController.allItems) {
      final weekStart = THelperFunctions.getStartOfWeek(order.orderDate);
      final now = DateTime.now();

      if (weekStart.isBefore(now) && weekStart.add(const Duration(days: 7)).isAfter(now)) {
        int index = (order.orderDate.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index;
        weeklySales[index] += order.totalAmount;
      }
    }
  }

  /// 📊 Calculate total orders and revenue by status
  void _calculateOrderStatusData() {
    orderStatusData.clear();
    totalAmounts.value = {
      for (var status in OrderStatus.values) status: 0.0,
    };

    for (var order in orderController.allItems) {
      final status = order.status;

      // Count orders
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Total revenue per status
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  /// 📘 Get readable label for an order status
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

  /// 🔎 (Optional) Search logic, currently disabled
  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  /// ❌ Order deletion (not implemented yet)
  @override
  Future<void> deleteItem(OrderModel item) async {}

  // ------------------------- 📈 Metric Utilities -------------------------

  /// 📆 Returns previous month in "MMM yyyy" format (e.g., Dec 2025)
  String getLastMonthFormatted() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1);
    return DateFormat('MMM yyyy').format(lastMonth);
  }

  /// 💰 Total sales revenue
  double getTotalSales() {
    return orderController.allItems.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  /// 📦 Total number of orders
  int getTotalOrders() {
    return orderController.allItems.length;
  }

  /// 🧾 Average order value = total sales / number of orders
  double getAverageOrderValue() {
    final total = getTotalSales();
    final count = getTotalOrders();
    return count == 0 ? 0.0 : total / count;
  }

  /// 👥 Total customers
  int getTotalCustomers() {
    return customerController.allItems.length;
  }


  /// 📈 Returns a widget showing percentage change with colored arrow
  Widget getPercentageIndicator(double current, double last, BuildContext context,
      {bool showIcon = true}) {
    final percent = last == 0 ? (current > 0 ? 100.0 : 0.0) : ((current - last) / last) * 100;
    final isPositive = percent >= 0;

    return Row(
      children: [
        if(showIcon)
        Icon(
          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
          color: isPositive ? TColors.success : TColors.error,
          size: TSizes.iconSm,
        ),
        Text(
          '${percent.toStringAsFixed(2)}%',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: isPositive ? TColors.success : TColors.error,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }


  // ------------------------- 🔁 Growth Percentage Metrics -------------------------

  /// 👥 % increase in customer count based on `createdAt`
  Widget getCustomerGrowthWidget(BuildContext context) {
    final now = DateTime.now();
    final customers = customerController.allItems;

    final currentMonth = customers
        .where((c) => c.createdAt.month == now.month && c.createdAt.year == now.year)
        .length
        .toDouble();

    final lastMonth = customers
        .where((c) => c.createdAt.month == now.month - 1 && c.createdAt.year == now.year)
        .length
        .toDouble();

    return getPercentageIndicator(currentMonth, lastMonth,context,showIcon: false);
  }

  /// 📦 % increase in number of orders this month vs last month
  Widget getOrderCountGrowthWidget(BuildContext context) {
    final now = DateTime.now();
    final orders = orderController.allItems;

    final current = orders
        .where((o) => o.orderDate.month == now.month && o.orderDate.year == now.year)
        .length
        .toDouble();

    final last = orders
        .where((o) => o.orderDate.month == now.month - 1 && o.orderDate.year == now.year)
        .length
        .toDouble();

    return getPercentageIndicator(current, last,context,);
  }

  /// 💵 % increase in sales this month vs last month
  Widget getSalesGrowthWidget(BuildContext context) {
    final now = DateTime.now();
    final orders = orderController.allItems;

    final current = orders
        .where((o) => o.orderDate.month == now.month && o.orderDate.year == now.year)
        .fold(0.0, (sum, o) => sum + o.totalAmount);

    final last = orders
        .where((o) => o.orderDate.month == now.month - 1 && o.orderDate.year == now.year)
        .fold(0.0, (sum, o) => sum + o.totalAmount);

    return getPercentageIndicator(current, last,context,);
  }

  /// 🧾 % increase in average order value this month vs last month
  Widget getAvgOrderValueGrowthWidget(BuildContext context) {
    final now = DateTime.now();
    final orders = orderController.allItems;

    final currentOrders = orders
        .where((o) => o.orderDate.month == now.month && o.orderDate.year == now.year);

    final currentTotal = currentOrders.fold(0.0, (sum, o) => sum + o.totalAmount);
    final currentAvg = currentOrders.isEmpty ? 0.0 : currentTotal / currentOrders.length;

    final lastOrders = orders
        .where((o) => o.orderDate.month == now.month - 1 && o.orderDate.year == now.year);

    final lastTotal = lastOrders.fold(0.0, (sum, o) => sum + o.totalAmount);
    final lastAvg = lastOrders.isEmpty ? 0.0 : lastTotal / lastOrders.length;

    return getPercentageIndicator(currentAvg, lastAvg,context,);
  }
}
