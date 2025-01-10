import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BannersRows extends DataTableSource {
  late final CategoryModel category;

  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(
        TRoundedImage(
          width: 180,
          height: 100,
          padding: TSizes.sm,
          image: TImages.banner1,
          imageType: ImageType.network,
          borderRadius: TSizes.borderRadiusMd,
          backgroundColor: TColors.primaryBackground,
        ),
      ),
      DataCell(
        Text("Shop"),
      ),
      DataCell(Icon(
        Iconsax.eye,
        color: TColors.primary,
      )),
      DataCell(TTableActionButtons(
        onEditPressed: () => Get.toNamed(TRoutes.editBanner,
            arguments:
                BannerModel(imageUrl: "", targetScreen: "", active: false)),
        onDeletePressed: () {},
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
