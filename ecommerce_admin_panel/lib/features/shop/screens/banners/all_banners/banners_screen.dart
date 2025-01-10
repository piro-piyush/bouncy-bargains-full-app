import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_tablet_screen.dart';
import 'package:flutter/material.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: BannersDesktopScreen(),
      tablet: BannersTabletScreen(),
      mobile: BannersMobileScreen(),
    );
  }
}
