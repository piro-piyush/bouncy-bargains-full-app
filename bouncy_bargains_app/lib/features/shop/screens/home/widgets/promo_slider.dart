import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:bouncy_bargain/common/widgets/images/x_rounded_image.dart';
import 'package:bouncy_bargain/features/shop/controllers/home_controller.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XPromoSlider extends StatelessWidget {
  const XPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        // Carousel Slider
        CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index)),
            items: banners.map((url) => XRoundedImage(imageUrl: url)).toList()),
        const SizedBox(
          height: XSizes.spaceBtwItems,
        ),

        Obx(() => Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < banners.length; i++)
                    XCircularContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? XColors.primary
                              : XColors.grey,
                    ),
                ],
              ),
            ))
      ],
    );
  }
}
