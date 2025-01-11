import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_screens/orders_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/responsive_screens/orders_tablet_screen.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}
