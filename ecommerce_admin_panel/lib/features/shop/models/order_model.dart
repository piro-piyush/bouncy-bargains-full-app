import 'package:ecommerce_admin_panel/utils/constants/enums.dart';

class OrderModel {
  String id;
  OrderStatus status;
  double totalAmount;
  DateTime orderDate;
  DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });
}
