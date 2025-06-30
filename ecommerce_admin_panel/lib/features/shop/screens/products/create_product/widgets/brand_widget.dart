import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:ecommerce_admin_panel/features/shop/bindings/brand/brand_bindings.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductsBrand extends StatelessWidget {
  const ProductsBrand({super.key});

  @override
  Widget build(BuildContext context) {
    // Get instance of controllers
    final controller = CreateProductController.instance;
    // BrandBindings().dependencies();
    final brandController = BrandController.instance;

    // Fetch brands if the list is empty
    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text(
            "Brand",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // TypeAheadField for Brand Selection
          Obx(() => brandController.isLoading.value
              ? TShimmerEffect(width: double.infinity, height: 50)
              : TypeAheadField(
                  builder: (context, ctr, focusNode) {
                    return TextFormField(
                      focusNode: focusNode,
                      controller: controller.brandTextField = ctr,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Select Brand",
                          suffixIcon: Icon(Iconsax.box)),
                    );
                  },
                  suggestionsCallback: (pattern) {
                    // Return filtered brand suggestions bases on the search pattern
                    return brandController.allItems
                        .where((brand) => brand.name.contains(pattern))
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion.name));
                  },
                  onSelected: (suggestion) {
                    controller.selectedBrand.value = suggestion;
                    controller.brandTextField.text = suggestion.name;
                  },
                ))
        ],
      ),
    );
  }
}
