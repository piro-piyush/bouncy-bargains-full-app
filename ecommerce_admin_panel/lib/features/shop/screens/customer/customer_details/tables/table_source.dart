import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerOrderRows extends DataTableSource {
  late final CategoryModel category;

  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
        id: "id",
        status: OrderStatus.shipped,
        totalAmount: 234.2,
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now());
    final totalAmount = '232.3';
    return DataRow2(
        selected: false,
        onTap: () => Get.toNamed(TRoutes.ordersDetails, arguments: order),
        cells: [
          DataCell(
            Text(
              order.id,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
            ),
          ),
          DataCell(
            Text(order.formattedOrderDate),
          ),
          DataCell(
            Text('${5} items'),
          ),
          DataCell(TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(
                vertical: TSizes.sm, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
                .withValues(alpha: 0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                  color: THelperFunctions.getOrderStatusColor(order.status)),
            ),
          )),
          DataCell(
            Text('\$$totalAmount'),
          ),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
