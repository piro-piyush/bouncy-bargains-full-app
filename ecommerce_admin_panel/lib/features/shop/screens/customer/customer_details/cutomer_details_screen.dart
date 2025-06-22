import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_screens/customer_details_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_screens/customer_details_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/responsive_screens/customer_details_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final controller = Get.put(CustomerDetailsController());
     controller.init(customer);
    return TSiteTemplate(
      desktop: CustomerDetailsDesktopScreen(customer: customer),
      tablet: CustomerDetailsTabletScreen(customer: customer),
      mobile: CustomerDetailsMobileScreen(customer: customer),
    );
  }
}
