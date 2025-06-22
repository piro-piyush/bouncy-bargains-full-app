import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/tables/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerController.instance;
    return Obx(() {
      // Customers & selected Rows are hidden => Just to update the UI => Obx => [ProductRows]
      Text(
        controller.filteredItems.length.toString(),
      );
      Text(controller.selectedRows.length.toString());

      return TPaginatedDataTable(
          minWidth: 700,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(
              label: Text("Customer"),
              onSort: (columnIndex, ascending) =>
                  controller.sortByName(columnIndex, ascending),
            ),
            DataColumn2(
              label: Text("Email"),
            ),
            DataColumn2(
              label: Text("Phone Number"),
            ),
            DataColumn2(
              label: Text("Registered"),
            ),
            DataColumn2(label: Text("Action"), fixedWidth: 100),
          ],
          source: CustomerRows());
    });
  }
}
