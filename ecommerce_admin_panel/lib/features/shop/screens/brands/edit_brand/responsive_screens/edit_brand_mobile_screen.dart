import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/widgets/edit_brand_form.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBrandMobileScreen extends StatelessWidget {
  const EditBrandMobileScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(heading: "Update Brand", breadcrumbItems: [TRoutes.brands,"Update Brand"],returnToPreviousScreen: true,),
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Form
              EditBrandForm(brand:brand)
            ],
          ),
        ),
      ),
    );
  }
}
