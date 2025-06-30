import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/tables/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrdersTabletScreen extends StatelessWidget {
  const OrdersTabletScreen({super.key});

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
                  heading: "Orders", breadcrumbItems: ["Orders"]),
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
                      showLeftWidget: false,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    // Table
                    OrderTable(),
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
