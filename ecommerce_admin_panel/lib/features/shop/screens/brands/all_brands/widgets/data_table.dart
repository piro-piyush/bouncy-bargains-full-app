import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/widgets/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandTable extends StatelessWidget {
   BrandTable({super.key});
  final controller = BrandController.instance;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      final lgTable = controller.filteredItems.any((element) =>
          element.brandCategories != null &&
          element.brandCategories!.length > 2);

      return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: lgTable ? 96 * 11.5 : 760,
          dataRowHeight: lgTable ? 96 : 64,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: Text("Brand"),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 200,
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: Text("Categories"),
                onSort: (columnIndex, ascending) =>
                    controller.sortByName(columnIndex, ascending)),
            DataColumn2(
                label: Text("Featured"),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 100),
            DataColumn2(
                label: Text("Date"),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 200),
            DataColumn2(
                label: Text("Action"),
                fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 100),
          ],
          source: BrandRows());
    });
  }
}
