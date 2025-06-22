import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/customer_address.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/customer_info.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/widgets/customer_orders.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerDetailsTabletScreen extends StatelessWidget {
   CustomerDetailsTabletScreen({super.key, required this.customer});

  final UserModel customer;
  final controller = CustomerDetailsController.instance;
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
                  returnToPreviousScreen: true,
                  heading: "Piyush",
                  breadcrumbItems: [TRoutes.customers, "Details"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Body
              CustomerInfo(customer: customer),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Shipping Address
              ShippingAddress(),
              SizedBox(
                width: TSizes.spaceBtwSections,
              ),

              // Right Side Customer Orders
              CustomerOrders()
            ],
          ),
        ),
      ),
    );
  }
}
