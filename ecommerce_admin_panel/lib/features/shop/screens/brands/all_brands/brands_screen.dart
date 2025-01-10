import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/responsive_screens/brands_mobile_screen.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/brands_tablet_screen.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsTabletScreen(),
      mobile: BrandsMobileScreen(),
    );
  }
}
