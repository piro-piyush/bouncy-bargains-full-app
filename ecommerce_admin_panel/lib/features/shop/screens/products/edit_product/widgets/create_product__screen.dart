import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/responsive_screens/create_product_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/responsive_screens/create_product_mobile_screen.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      mobile: CreateProductMobileScreen(),
    );
  }
}
