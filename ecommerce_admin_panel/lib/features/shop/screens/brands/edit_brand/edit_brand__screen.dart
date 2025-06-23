import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brand_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/responsive_screens/edit_brand_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsive_screens/edit_brand_tablet_screen.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    final controller = EditBrandController.instance;
    controller.init(brand);
    return TSiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand),
      tablet: EditBrandTabletScreen(brand: brand),
      mobile: EditBrandMobileScreen(brand: brand),
    );
  }
}
