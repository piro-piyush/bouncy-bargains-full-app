import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brand_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/responsive_screens/create_brand_mobile_screen.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/create_brand_tablet_screen.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
