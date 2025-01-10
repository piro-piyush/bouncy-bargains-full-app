import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/responsive_screens/categories_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/responsive_screens/categories_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/responsive_screens/categories_tablet_screen.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CategoriesDesktopScreen(),
      tablet: CategoriesTabletScreen(),
      mobile: CategoriesMobileScreen(),
    );
  }
}
