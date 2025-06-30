import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/tables/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =CustomerController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Customers", breadcrumbItems: ["Customers"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      onSearchChange: (query) => controller.searchQuery(query),

                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return TLoaderAnimation();
                      }
                      return CustomersTable();
                    }),
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
