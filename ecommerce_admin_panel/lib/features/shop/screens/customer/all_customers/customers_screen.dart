import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_tablet_screen.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CustomersDesktopScreen(),
      tablet: CustomersTabletScreen(),
      mobile: CustomersMobileScreen(),
    );
  }
}
