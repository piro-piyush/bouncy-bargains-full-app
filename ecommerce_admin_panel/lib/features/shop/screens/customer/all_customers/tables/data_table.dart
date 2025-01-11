import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/tables/table_source.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/tables/table_source.dart';
import 'package:flutter/material.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        columns: [
          DataColumn2(
            label: Text("Customer"),
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
  }
}
