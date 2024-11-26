import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/brands/brand_card.dart';
import 'package:bouncy_bargain/common/widgets/products/sortable/sortable_products.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: XAppBar(
        title: Text("Nike"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Detail
              XBrandCard(showBorder: true),
              SizedBox(height: XSizes.spaceBtwSections,),

              XSortableProducts()
            ],
          ),
        ),
      ),
    );
  }
}
