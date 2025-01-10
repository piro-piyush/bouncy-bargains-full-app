import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/widgets/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Brand", breadcrumbItems: ["Brands"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Table Body
              // Should be in obx
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: "Create New Brand",
                      onPressed: () => Get.toNamed(TRoutes.createBrand),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Table
                    BrandTable(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
