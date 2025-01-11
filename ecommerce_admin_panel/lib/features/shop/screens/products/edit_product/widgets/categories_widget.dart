import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductsCategories extends StatelessWidget {
  const ProductsCategories({super.key});

  @override
  Widget build(BuildContext context) {
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
          MultiSelectDialogField(
              buttonText: Text("Select Categories"),
              title: Text("Categories"),
              items: [
                MultiSelectItem(
                    CategoryModel(id: "", name: "", image: ""), "Shoes"),
                MultiSelectItem(
                    CategoryModel(id: "", name: "", image: ""), "Shirts"),
              ],
              listType: MultiSelectListType.CHIP,
              onConfirm: (value) {})
        ],
      ),
    );
  }
}
