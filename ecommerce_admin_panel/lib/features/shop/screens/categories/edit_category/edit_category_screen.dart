import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/edit_category/responsive_screens/edit_categories_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/edit_category/responsive_screens/edit_categories_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/edit_category/responsive_screens/edit_categories_tablet_screen.dart';
import 'package:flutter/material.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = CategoryModel(id: "", name: "", image: "");
    return TSiteTemplate(
      desktop: EditCategoriesDesktopScreen(
        category: category,
      ),
      tablet: EditCategoriesTabletScreen(
        category: category,
      ),
      mobile: EditCategoriesMobileScreen(
        category: category,
      ),
    );
  }
}