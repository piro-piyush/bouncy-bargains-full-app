import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class XUserProfileTile extends StatelessWidget {
  const XUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(
      () => ListTile(
        leading: XCircularImage(
          image: controller.user.value.profilePicture != ""
              ? controller.user.value.profilePicture
              : XImages.user,
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: controller.user.value.profilePicture != "",
        ),
        title: Text(
          controller.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: XColors.white),
        ),
        subtitle: Text(
          controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: XColors.white),
        ),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Iconsax.edit,
              color: XColors.white,
            )),
      ),
    );
  }
}
