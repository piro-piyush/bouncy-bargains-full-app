import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail Text
          Text(
            "Product Thumbnail",
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // Container for Product Thumbnail
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Obx(() {
                            return TRoundedImage(
                              imageType:
                              controller.productImagesController
                                  .selectedThumbnailImageUrl.value == null
                                  ? ImageType.asset
                                  : ImageType.network,
                              height: 220,
                              width: 220,
                              image: controller.productImagesController
                                  .selectedThumbnailImageUrl.value ??
                                  TImages.defaultSingleImageIcon,
                            );
                          }))
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                        onPressed: () {
                          controller.productImagesController
                              .selectedThumbnailImage();
                        },
                        child: Text("Add Thumbnail")),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
