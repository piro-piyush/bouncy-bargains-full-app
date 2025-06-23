import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/table_scource.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardOrderTable extends StatelessWidget {
  DashboardOrderTable({super.key});

  final controller = DashboardController.instance;

  @override
  Widget build(BuildContext context) {
    final orderController = controller.orderController;
    return Obx(() {
      Text(orderController.filteredItems.length.toString());
      Text(orderController.selectedRows.length.toString());
      return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: 500,
          dataRowHeight: TSizes.xl * 1.2,
          sortAscending: orderController.sortAscending.value,
          sortColumnIndex: orderController.sortColumnIndex.value,
          columns: [
            DataColumn2(label: Text('Order ID'),onSort: (columnIndex, ascending) => orderController.sortById(columnIndex, ascending)),
            DataColumn2(label: Text('Date'),onSort: (columnIndex, ascending) => orderController.sortByDate(columnIndex, ascending)),
            DataColumn2(label: Text('Items')),
            DataColumn2(label: Text('Status'),fixedWidth: TDeviceUtils.isMobileScreen(context)? 120: null),
            DataColumn2(label: Text('Amount')),
          ],
          source: OrderRows());
    });
  }
}
