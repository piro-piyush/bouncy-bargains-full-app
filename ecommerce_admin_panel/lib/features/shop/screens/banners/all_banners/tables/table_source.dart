import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRows extends DataTableSource {
  final controller = BannerController.instance;

  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];
    return DataRow2(
        selected: controller.selectedRows[index],
        onTap: () => Get.toNamed(TRoutes.editBanner, arguments: banner),
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(
            TRoundedImage(
              width: 180,
              height: 100,
              padding: TSizes.sm,
              image: banner.imageUrl,
              imageType: ImageType.network,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
          ),
          DataCell(
            Text(banner.formatRoute()),
          ),
          DataCell(banner.active
              ? Icon(
                  Iconsax.eye,
                  color: TColors.primary,
                )
              : Icon(
                  Iconsax.eye_slash,
                )),
          DataCell(TTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(TRoutes.editBanner, arguments: banner),
            onDeletePressed: () => controller.confirmAndDeleteItem(banner),
          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
