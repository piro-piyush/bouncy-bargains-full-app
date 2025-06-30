import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/table/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesMobileScreen extends StatelessWidget {
  const CategoriesMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Categories", breadcrumbItems: ["Categories"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Table Body
             TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: "Create New Category",
                        onPressed: () => Get.toNamed(TRoutes.createCategory),
                        searchController: controller.searchTextController,
                        onSearchChange: (query) =>
                            controller.searchQuery(query),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      // Table
                      Obx(() {
                        if (controller.isLoading.value) return TLoaderAnimation();
                        return CategoryTable();
                      })
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
