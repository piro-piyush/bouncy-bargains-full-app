import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/tables/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomersTabletScreen extends StatelessWidget {
  const CustomersTabletScreen({super.key});



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
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Table
                    CustomersTable(),
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
