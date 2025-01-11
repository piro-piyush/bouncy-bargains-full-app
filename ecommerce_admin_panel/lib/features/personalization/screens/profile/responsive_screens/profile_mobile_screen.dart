import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/widgets/form.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/widgets/image_meta.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Profile", breadcrumbItems: ["Profile"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Body
              ImageAndMeta(),
              SizedBox(
                width: TSizes.spaceBtwSections,
              ),

              // Form
              ProfileForm()
            ],
          ),
        ),
      ),
    );
  }
}
