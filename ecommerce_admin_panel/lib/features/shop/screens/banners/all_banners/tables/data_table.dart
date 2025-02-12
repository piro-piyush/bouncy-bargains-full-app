import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/tables/table_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerTable extends StatelessWidget {
  const BannerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BannerController.instance;
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
      return TPaginatedDataTable(
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          columns: [
            DataColumn2(
              label: Text("Banner"),
            ),
            DataColumn2(
              label: Text("Redirect Screen"),
            ),
            DataColumn2(
              label: Text("Active"),
            ),
            DataColumn2(label: Text("Action"), fixedWidth: 100),
          ],
          source: BannersRows());
    });
  }
}
