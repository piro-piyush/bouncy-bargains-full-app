import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/brands/brand_card.dart';
import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/shop/screens/brands/brand_products.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const XAppBar(
        title: Text("Brands"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Heading
              const XSectionHeading(
                title: "Brands",
                showActionButton: false,
              ),
              const SizedBox(
                height: XSizes.spaceBtwItems,
              ),

              // Brands
              XGridLayout(
                  mainAxisExtent: 80,
                  itemCount: 12,
                  itemBuilder: (_, index) => XBrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => const BrandProducts()),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
