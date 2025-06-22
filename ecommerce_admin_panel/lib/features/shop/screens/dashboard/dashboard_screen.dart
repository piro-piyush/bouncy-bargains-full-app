import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/responsive_screen/dashboard_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/responsive_screen/dashboard_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/responsive_screen/dashboard_tablet_screen.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProductImagesController());
    return TSiteTemplate(
      desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),
    );
  }
}
