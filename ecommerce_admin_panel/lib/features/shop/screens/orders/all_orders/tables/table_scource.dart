import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  final controller = DashboardController.instance;
  @override
  DataRow? getRow(int index) {
    final orderController = controller.orderController;
    final order = orderController.filteredItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
        selected: false,
        onSelectChanged: (value) {},
        cells: [
          DataCell(Text(
            order.id,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
          )),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items.length} Items')),
          DataCell(TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: EdgeInsets.symmetric(
                vertical: TSizes.sm, horizontal: TSizes.md),
            backgroundColor: THelperFunctions.getOrderStatusColor(order.status)
                .withValues(alpha: 0.1),
            child: Text(
              order.status.name.toString(),
              style: TextStyle(
                  color: THelperFunctions.getOrderStatusColor(order.status)),
            ),
          )),
          DataCell(Text('\$${order.totalAmount}')),
          DataCell(TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () =>
                Get.toNamed(TRoutes.orderDetails, arguments: order),
            onDeletePressed: () {},
          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.orderController.filteredItems.length;

  @override
  int get selectedRowCount => controller.orderController.selectedRows.where((element) => element).length;
}
