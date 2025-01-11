import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_screens/order_details_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_screens/order_details_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/responsive_screens/order_details_tablet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    return TSiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
      tablet: OrderDetailsTabletScreen(order: order),
      mobile: OrderDetailsMobileScreen(order: order),
    );
  }
}
