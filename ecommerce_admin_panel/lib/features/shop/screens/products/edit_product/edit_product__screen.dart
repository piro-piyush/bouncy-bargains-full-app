import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/responsive_screens/edit_product_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/responsive_screens/edit_product_mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsive_screens/edit_product_tablet_screen.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.init(product);
    return TSiteTemplate(
      desktop: EditProductDesktopScreen(
        product: product,
      ),
      tablet: EditProductTabletScreen(
        product: product,
      ),
      mobile: EditProductMobileScreen(
        product: product,
      ),
    );
  }
}
