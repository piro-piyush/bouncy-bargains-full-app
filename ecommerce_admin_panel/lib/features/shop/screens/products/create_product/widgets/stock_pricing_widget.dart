import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stock
          FractionallySizedBox(
            widthFactor: 0.45,
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Stock",
                  hintText: "Add Stock only number allowed"),
              validator: (value) =>
                  TValidator.validateEmptyText("Stock", value),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // Pricing
          Row(
            children: [
              // Price
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Price with up-to 2 decimals",
                ),
                validator: (value) =>
                    TValidator.validateEmptyText("Price", value),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?d{0,2}$'))
                ],
              )),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),

              // Sale Price
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Discounted Price",
                  hintText: "Price with up-to 2 decimals",
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?d{0,2}$'))
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
