import 'package:bouncy_bargain/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:bouncy_bargain/common/widgets/shimmers/category_shimmer.dart';
import 'package:bouncy_bargain/features/shop/controllers/category_controller.dart';
import 'package:bouncy_bargain/features/shop/screens/sub_category/sub_category_screen.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XHomeCategories extends StatelessWidget {
  const XHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Obx(() {
      if (controller.isLoading.value) return const XCategoryShimmer();
      if (controller.featuredCategories.isEmpty) {
        return Center(
            child: Text("No Data Found!",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: XColors.white)));
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category  = controller.featuredCategories[index];
              return XVerticalImageText(
                image: category.image,
                title: category.name,
                onTapped: () {
                  Get.to(() => const SubCategoryScreen());
                },
              );
            }),
      );
    });
  }
}
