import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            groupValue: ProductType.single,
            onChanged: (value) {},
            child: Text("Single")),

        // Radio Button for Variable Product Type
        RadioMenuButton(
            value: ProductType.variable,
            groupValue: ProductType.single,
            onChanged: (value) {},
            child: Text("Variable"))
      ],
    );
  }
}
