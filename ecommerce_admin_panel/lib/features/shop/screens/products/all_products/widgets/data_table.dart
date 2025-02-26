import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/widgets/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return TPaginatedDataTable(
          minWidth: 1000,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
                label: Text("Products"),
                fixedWidth: !TDeviceUtils.isDesktopScreen(context) ? 300 : 400,
              onSort: (columnIndex, ascending) =>controller.sortByName(columnIndex, ascending)
            ),
            DataColumn2(
              label: Text("Stock"),
              onSort: (columnIndex, ascending) =>controller.sortByStock(columnIndex, ascending)
            ),
            DataColumn2(
                label: Text("Sold"),
                onSort: (columnIndex, ascending) =>controller.sortBySoldQuantity(columnIndex, ascending)
            ),
            DataColumn2(
              label: Text("Brand"),
            ),
            DataColumn2(
              label: Text("Price"),
              onSort: (columnIndex, ascending) =>controller.sortByPrice(columnIndex, ascending)
            ),
            DataColumn2(
              label: Text("Date"),
            ),
            DataColumn2(label: Text("Action"), fixedWidth: 100),
          ],
          source: ProductsRows());
    });
  }
}
