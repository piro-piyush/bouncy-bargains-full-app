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

  // final AddressModel? address;
  // final ItemModel? items;
  final DateTime? deliveryDate;

  // final List<CartItemModel> items;

  OrderModel({
    this.userId = '',
    this.docId = '',
    this.paymentMethod = 'Paypal',
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? "Shipment on the way"
          : 'Processing';
}
