import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/widgets/order_customer.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/widgets/order_info.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/widgets/order_items.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/widgets/order_transactions.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailsMobileScreen extends StatelessWidget {
  const OrderDetailsMobileScreen({super.key, required this.order});

  final OrderModel order;

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
                  returnToPreviousScreen: true,
                  heading: order.id,
                  breadcrumbItems: [TRoutes.orders, "Details"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //  Body
              // Should be in Obx
              OrderInfo(order: order),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Items
              OrderItems(order: order),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Transactions
              OrderTransactions(order: order),
              SizedBox(
                width: TSizes.spaceBtwSections,
              ),
              // Right Side Order Information
              OrderCustomer(order: order),
            ],
          ),
        ),
      ),
    );
  }
}
