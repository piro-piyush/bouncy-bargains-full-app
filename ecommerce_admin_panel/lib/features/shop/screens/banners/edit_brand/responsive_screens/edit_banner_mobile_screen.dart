import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_brand/widgets/edit_banner_form.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBannerMobileScreen extends StatelessWidget {
  const EditBannerMobileScreen({super.key, required this.banner});

  final BannerModel banner;

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
              const TBreadcrumbWithHeading(
                  heading: "Update Banner",
                  breadcrumbItems: [TRoutes.brands, "Update Banner"]),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Form
              EditBannerForm(banner: banner)
            ],
          ),
        ),
      ),
    );
  }
}