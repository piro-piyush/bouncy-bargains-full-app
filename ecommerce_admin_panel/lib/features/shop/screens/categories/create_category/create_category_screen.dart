import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/create_category/responsive_screens/create_category_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/create_category/responsive_screens/create_category_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/create_category/responsive_screens/create_category_tablet_screen.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CreateCategoryTabletScreen(),
      mobile: CreateCategoryMobileScreen(),
    );
  }
}
