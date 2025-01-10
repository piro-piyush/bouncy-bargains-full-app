import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRows extends DataTableSource {
   // final CategoryModel category;

  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(Row(
        children: [
          TRoundedImage(
            width: 50,
            height: 50,
            padding: TSizes.sm,
            image: TImages.facebook,
            imageType: ImageType.asset,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
          SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Expanded(
            child: Text(
              "Name",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      )),
      DataCell(Text("Parent")),
      DataCell(Icon(
        Iconsax.heart5,
        color: TColors.primary,
      )),
      DataCell(Text(DateTime.now().toString())),
      DataCell(TTableActionButtons(
        onEditPressed: () =>
            Get.toNamed(TRoutes.editCategory,
                // arguments: 'category'
            ),
        onDeletePressed: () {},
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 5;
}
