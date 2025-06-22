import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductBottomNavigationBar extends StatelessWidget {
  const ProductBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () =>
                    CreateProductController.instance.createProduct(),
                child: Text("Save Changes")),
          )
        ],
      ),
    );
  }
}
