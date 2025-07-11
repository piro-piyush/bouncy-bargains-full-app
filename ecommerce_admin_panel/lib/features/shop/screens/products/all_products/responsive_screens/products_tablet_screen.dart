import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/widgets/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsTabletScreen extends StatelessWidget {
  const ProductsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Banners", breadcrumbItems: ["Banners"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Table Body
              Obx(() {
                // Show loader
                if (controller.isLoading.value) return TLoaderAnimation();

                return TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: "Add Product",
                        onPressed: () => Get.toNamed(TRoutes.createProduct),
                        searchController: controller.searchTextController,
                        onSearchChange: (query) =>
                            controller.searchQuery(query),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      // Table
                      ProductsTable(),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
