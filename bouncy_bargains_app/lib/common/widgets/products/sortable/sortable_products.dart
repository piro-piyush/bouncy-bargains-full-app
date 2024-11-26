import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XSortableProducts extends StatelessWidget {
  const XSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown menu
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)), items: ['Name', 'Higher Price', 'Lower Price', 'Sale', "Newest", 'Popularity'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(), onChanged: (value) {}),

        const SizedBox(
          height: XSizes.spaceBtwSections,
        ),

        // Products
        XGridLayout(itemCount: 8, itemBuilder: (_, index) => const XProductCardVertical())
      ],
    );
  }
}
