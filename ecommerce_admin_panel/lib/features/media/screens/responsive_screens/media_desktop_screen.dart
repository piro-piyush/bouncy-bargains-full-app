import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_content.dart';
import 'package:ecommerce_admin_panel/features/media/screens/widgets/media_uploader.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  TBreadcrumbWithHeading(
                    heading: "Media",
                    breadcrumbItems: [ "Media"],
                  ),

                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                        onPressed: () => controller.showImageUploaderSection
                            .value = !controller.showImageUploaderSection.value,
                        icon: Icon(Iconsax.cloud_add),
                        label: Text("Upload Images")),
                  )
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Upload Area
              MediaUploader(),

              /// Media
              MediaContent(
                allowSelection: false,
                allowMultipleSelection: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
