import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
        onTap: () => Get.toNamed(TRoutes.customerDetails, arguments: customer),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) {
          controller.selectedRows[index] = value ?? false;
        },
        cells: [
          DataCell(
            Row(
              children: [
                TRoundedImage(
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                  width: 50,
                  height: 50,
                  padding: TSizes.sm,
                  image: customer.profilePicture,
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    child: Text(
                  customer.fullName.isNotEmpty ? customer.fullName : "N/A",
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            ),
          ),
          DataCell(Text(customer.email.isNotEmpty ? customer.email : "N/A")),
          DataCell(Text(
              customer.phoneNumber.isNotEmpty ? customer.phoneNumber : "N/A")),
          DataCell(Text(
              customer.createdAt != null ? customer.formattedDate : "N/A")),
          DataCell(TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () =>
                Get.toNamed(TRoutes.customerDetails, arguments: customer),
            onDeletePressed: () {
              controller.confirmAndDeleteItem(customer);
            },
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((row) => row).length;
}
