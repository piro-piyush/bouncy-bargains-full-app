import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/additional_images.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/attributes_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/bottom_navigation_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/brand_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/categories_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/product_type_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/stock_pricing_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/thumbnail_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/title_description.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/variations_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/widgets/visibility_widget.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class CreateProductTabletScreen extends StatelessWidget {
  const CreateProductTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    final imageController = controller.productImagesController;
    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                  returnToPreviousScreen: true,
                  heading: "Create Product",
                  breadcrumbItems: [TRoutes.products, "Create Product"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information
                          ProductTitleAndDescription(),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Stock and Pricing
                          TRoundedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading
                                Text(
                                  "Stock & Pricing",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(
                                  height: TSizes.spaceBtwItems,
                                ),

                                // Product Type
                                ProductTypeWidget(),
                                SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),

                                // Stock
                                ProductStockAndPricing(),
                                SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),

                                // Actions
                                ProductAttributes(),
                                SizedBox(
                                  height: TSizes.spaceBtwSections,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Variations
                          ProductVariations(),
                        ],
                      )),
                  SizedBox(
                    width: TSizes.defaultSpace,
                  ),

                  // SideBar
                  Expanded(
                      child: Column(
                    children: [
                      // Product Thumbnail
                      ProductThumbnailImage(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Product Images
                      TRoundedContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Product Images",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            SizedBox(
                              height: TSizes.spaceBtwItems,
                            ),
                            ProductAdditionalImages(
                                additionalProductImageURLs:
                                imageController.additionalProductImageUrls,
                                onTapToAddImages: () => imageController
                                    .selectMultipleProductImages(),
                                onTapToRemoveImages: (index) =>
                                    imageController.removeImage(index))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Products Brand
                      ProductsBrand(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Products Categories
                      ProductsCategories(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Products Brand
                      ProductsVisibilityWidget(),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Products Images
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
