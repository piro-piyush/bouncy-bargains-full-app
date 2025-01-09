import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .apply(color: TColors.primary),
      )),
      DataCell(Text(order.formattedOrderDate)),
      const DataCell(Text("5 items")),
      DataCell(TRoundedContainer(
        radius: TSizes.cardRadiusSm,
        padding:
            EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.md),
        backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
            .withValues(alpha: 0.1),
        child: Text(
          order.status.name.toString(),
          style: TextStyle(
              color: THelperFunctions.getOrderStatusColor(order.status)),
        ),
      )),
      DataCell(Text('\$${order.totalAmount}')),
    ]);
  }

  @override
  bool get isRowCountApproximate =>false;

  @override
  int get rowCount =>DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
