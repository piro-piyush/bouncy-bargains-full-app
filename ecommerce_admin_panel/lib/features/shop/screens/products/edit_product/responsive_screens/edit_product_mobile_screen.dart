import 'package:ecommerce_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart' show EditProductController;
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart' show ProductModel;
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/additional_images.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/attributes_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/brand_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/categories_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/product_type_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/stock_pricing_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/thumbnail_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/title_description.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/variations_widget.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/widgets/visibility_widget.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditProductMobileScreen extends StatelessWidget {
  final ProductModel product;
  const EditProductMobileScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
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
                  heading: "Edit Product",
                  breadcrumbItems: [TRoutes.products, "Edit Product"]),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Create Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          style: Theme.of(context).textTheme.headlineSmall,
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
                  SizedBox(
                    height: TSizes.defaultSpace,
                  ),

                  // SideBar
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
                            additionalProductImageURLs: controller
                                .productImagesController
                                .additionalProductImageUrls,
                            onTapToAddImages: () {
                              controller.productImagesController
                                  .selectMultipleProductImages();
                            },
                            onTapToRemoveImages: (index) {
                              controller.productImagesController
                                  .removeImage(index);
                            })
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
                  ProductsCategories(productModel:product),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Products Brand
                  ProductsVisibilityWidget(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
