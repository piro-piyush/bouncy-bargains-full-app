import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/table/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesDesktopScreen extends StatelessWidget {
  const CategoriesDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Should be in Obx
               TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: "Create New Category",
                        onPressed: () => Get.toNamed(TRoutes.createCategory),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      // Table
                      CategoryTable(),
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