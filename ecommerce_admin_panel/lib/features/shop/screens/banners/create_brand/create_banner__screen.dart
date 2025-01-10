import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_brand/responsive_screens/create_banner_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_brand/responsive_screens/create_banner_mobile_screen.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/create_banner_tablet_screen.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile: CreateBannerMobileScreen(),
    );
  }
}
