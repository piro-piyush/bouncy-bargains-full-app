import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return Obx(() {
      return Row(
        children: [
          Text(
            "Product Type",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            width: TSizes.spaceBtwItems,
          ),

          // Radio Button for Single Product Type
          RadioMenuButton(
              value: ProductType.single,
              groupValue: controller.productType.value,
              onChanged: (value) {
                controller.productType.value = value ?? ProductType.single;
              },
              child: Text("Single")),

          // Radio Button for Variable Product Type
          RadioMenuButton(
              value: ProductType.variable,
              groupValue: controller.productType.value,
              onChanged: (value) {
                controller.productType.value = value ?? ProductType.single;
              },
              child: Text("Variable"))
        ],
      );
    });
  }
}
