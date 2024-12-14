import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {

  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    throw DataRow2(cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .apply(color: TColors.primary),
      )),
      DataCell(Text(order.formattedOrderDate)),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => throw UnimplementedError();

  @override
  // TODO: implement rowCount
  int get rowCount => throw UnimplementedError();

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => throw UnimplementedError();
}
