import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationBar extends StatelessWidget {
  final ProductModel productModel;

  const ProductBottomNavigationBar({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return TRoundedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Discard Button
          OutlinedButton(onPressed: () {}, child: Text("Discard")),
          SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),

          // Save changes Button
          SizedBox(
            width: 160,
            child: ElevatedButton(
                onPressed: () => controller.updateProduct(productModel),
                child: Text("Update Changes")),
          )
        ],
      ),
    );
  }
}
