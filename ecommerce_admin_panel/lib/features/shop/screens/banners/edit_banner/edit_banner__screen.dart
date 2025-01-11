import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsive_screens/edit_banner_tablet_screen.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return TSiteTemplate(
      desktop: EditBannerDesktopScreen(
        banner: banner,
      ),
      tablet: EditBannerTabletScreen(banner: banner),
      mobile: EditBannerMobileScreen(banner: banner),
    );
  }
}
