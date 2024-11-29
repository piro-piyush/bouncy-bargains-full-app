import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/features/shop/screens/cart/cart_screen.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XHomeAppBar extends StatelessWidget {
  const XHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return XAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            XTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: XColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const XShimmerEffect(
                width: 80,
                height: 15,
              );
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: XColors.white),
              );
            }
          }
          )
        ],
      ),
      actions: [
        XCartCounterIcon(
          iconColor: XColors.white,
          onPressed: () {
            Get.to(() => const CartScreen());
          },
        )
      ],
    );
  }
}
