import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsVisibilityWidget extends StatelessWidget {
  ProductsVisibilityWidget({super.key});

  final controller = EditProductController.instance;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text(
            "Visibility",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // Radio buttons for product visibility
          Column(
            children: [
              buildVisibilityRadioButton(
                  ProductVisibility.published, "Published"),
              buildVisibilityRadioButton(ProductVisibility.hidden, "Hidden"),
            ],
          )
        ],
      ),
    );
  }

  Widget buildVisibilityRadioButton(ProductVisibility value, String label) {
    return Obx(() => RadioListTile<ProductVisibility>(
          value: value,
          groupValue: controller.productVisibility.value,
          onChanged: (selection) {
            controller.productVisibility.value =
                selection ?? controller.productVisibility.value;
          },
          title: Text(label),
        ));
  }
}
