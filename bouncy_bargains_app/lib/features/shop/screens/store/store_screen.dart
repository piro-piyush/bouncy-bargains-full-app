import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/appbar/tabbar.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/common/widgets/brands/brand_card.dart';
import 'package:bouncy_bargain/features/shop/screens/brands/all_brands_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/store/widgets/category_tab_bar.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: XAppBar(
          title: const Text('Store'),
          actions: [
            XCartCounterIcon(
              onPressed: () {},
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    pinned: true,
                    floating: true,
                    backgroundColor: dark ? XColors.black : XColors.white,
                    expandedHeight: 440,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(XSizes.defaultSpace),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          // Search Bar
                          const SizedBox(
                            height: XSizes.spaceBtwItems,
                          ),
                          const XSearchContainer(
                            text: 'Search in Store',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: XSizes.spaceBtwSections,
                          ),

                          // Feature Brands
                          XSectionHeading(
                            title: 'Feature Brands',
                            onPressed: () {
                              Get.to(() => const AllBrandsScreen());
                            },
                          ),
                          const SizedBox(
                            height: XSizes.spaceBtwItems / 1.5,
                          ),

                          XGridLayout(
                              itemCount: 4,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                return const XBrandCard(
                                  showBorder: true,
                                );
                              })
                        ],
                      ),
                    ),
                    bottom: const XTabBar(
                      tabs: [
                        Tab(
                          child: Text("Sports"),
                        ),
                        Tab(
                          child: Text("Furniture"),
                        ),
                        Tab(
                          child: Text("Electronics"),
                        ),
                        Tab(
                          child: Text("Clothes"),
                        ),
                        Tab(
                          child: Text("Electronics"),
                        ),
                      ],
                    ))
              ];
            },
            body: const TabBarView(children: [
              XCategoryTab(),
            ])),
      ),
    );
  }
}
