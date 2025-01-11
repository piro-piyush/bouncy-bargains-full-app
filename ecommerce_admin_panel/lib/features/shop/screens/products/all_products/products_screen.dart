import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/responsive_screens/banners_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_screens/products_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_screens/products_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/responsive_screens/products_tablet_screen.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ProductsDesktopScreen(),
      tablet: ProductsTabletScreen(),
      mobile: ProductsMobileScreen(),
    );
  }
}
