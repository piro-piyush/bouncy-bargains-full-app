import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductsRows extends DataTableSource {
  late final CategoryModel category;

  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(
        Row(
          children: [
            TRoundedImage(
              width: 50,
              height: 50,
              padding: TSizes.sm,
              image: TImages.banner1,
              imageType: ImageType.asset,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Flexible(
                child: Text(
              "Product Title",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary),
              overflow: TextOverflow.ellipsis,
            ))
          ],
        ),
      ),
      DataCell(
        Text("256"),
      ),

      // Brand
      DataCell(Row(
        children: [
          TRoundedImage(
            width: 35,
            height: 35,
            padding: TSizes.xs,
            image: TImages.nikeLogo,
            imageType: ImageType.asset,
            borderRadius: TSizes.borderRadiusMd,
            backgroundColor: TColors.primaryBackground,
          ),
          SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          Flexible(
              child: Text(
            "Nike",
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
            overflow: TextOverflow.ellipsis,
          ))
        ],
      )),

      DataCell(Text("\$99.9")),
      DataCell(Text(DateTime.now().toString())),
      DataCell(TTableActionButtons(
        onEditPressed: () =>
            Get.toNamed(TRoutes.editProduct, arguments: ProductModel.empty()),
        onDeletePressed: () {},
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
