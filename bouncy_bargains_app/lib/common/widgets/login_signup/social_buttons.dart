import 'package:bouncy_bargain/features/authentication/controllers/login/login_controller.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XSocialButtons extends StatelessWidget {
  const XSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: XColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () =>controller.googleSignIn(),
              icon: const Image(
                  width: XSizes.iconMd,
                  height: XSizes.iconMd,
                  image: AssetImage(XImages.google))),
        ),
        const SizedBox(
          width: XSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: XColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                  width: XSizes.iconMd,
                  height: XSizes.iconMd,
                  image: AssetImage(XImages.facebook))),
        ),
      ],
    );
  }
}
