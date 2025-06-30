import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/widgets/form.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/widgets/image_meta.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            spacing: TSizes.spaceBtwSections,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Settings", breadcrumbItems: ["Settings"]),

              ImageAndMeta(),

              // Form
              SettingsForm()
            ],
          ),
        ),
      ),
    );
  }
}
