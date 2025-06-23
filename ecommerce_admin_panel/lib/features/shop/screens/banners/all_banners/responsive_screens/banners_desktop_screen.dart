import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/tables/data_table.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannersDesktopScreen extends StatelessWidget {
  const BannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BannerController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  heading: "Banners", breadcrumbItems: ["Banners"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Table Body
              Obx(() {
                // Show loader
                if (controller.isLoading.value) return const TLoaderAnimation();

                return TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: "Create New Banner",
                        onPressed: () => Get.toNamed(TRoutes.createBanner),
                        showRightWidget: false,
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      // Table
                      BannerTable(),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
