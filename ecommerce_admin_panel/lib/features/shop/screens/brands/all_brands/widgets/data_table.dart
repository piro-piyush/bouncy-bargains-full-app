import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/widgets/table_source.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 760,
        dataRowHeight: 64,
        columns: [
          DataColumn2(
              label: Text("Brand"),
              fixedWidth: TDeviceUtils.isMobileScreen(context) ? null : 200),
          DataColumn2(
            label: Text("Categories"),
          ),
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
  }
}
