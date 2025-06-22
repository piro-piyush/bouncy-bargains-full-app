import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductsCategories extends StatelessWidget {
  final ProductModel productModel;

  const ProductsCategories({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text(
            "Categories",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // MultiSelectDialogField for selecting categories
          FutureBuilder(
              future: productController.loadSelectedCategories(productModel.id),
              builder: (context, snapshot) {
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (widget != null) {
                  return widget;
                }
                return MultiSelectDialogField(
                    buttonText: Text("Select Categories"),
                    title: Text("Categories"),
                    initialValue: List<CategoryModel>.from(
                        productController.selectedCategories),
                    items: CategoryController.instance.allItems
                        .map((c) => MultiSelectItem(c, c.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      productController.selectedCategories.assignAll(values);
                    });
              })
        ],
      ),
    );
  }
}
