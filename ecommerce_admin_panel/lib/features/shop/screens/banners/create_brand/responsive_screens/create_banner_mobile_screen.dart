import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_brand/widgets/create_banner_form.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannerMobileScreen extends StatelessWidget {
  const CreateBannerMobileScreen({super.key});

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
              TBreadcrumbWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Create Banner",
                  breadcrumbItems: [TRoutes.brands, "Create Banner"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Form
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
