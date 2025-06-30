import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: TColors.grey, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
          // Mobile Menu
          leading: !TDeviceUtils.isDesktopScreen(context)
              ? IconButton(
                  onPressed: () {
                    scaffoldKey?.currentState?.openDrawer();
                  },
                  icon: Icon(Iconsax.menu))
              : null,

          // Text Field
          title: TDeviceUtils.isDesktopScreen(context)
              ? SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.search_normal),
                        hintText: "Search anything ..."),
                  ),
                )
              : null,

          // Actions
          actions: [
            if (!TDeviceUtils.isDesktopScreen(context))
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.search_normal),
              ),

            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // User Info Row
            Obx(() {
              final isLoading = controller.loading.value;
              final admin = controller.admin.value;

              return Row(
                children: [
                  if (!TDeviceUtils.isMobileScreen(context))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isLoading
                            ? const TShimmerEffect(width: 80, height: 13)
                            : Text(
                                admin.fullName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                        const SizedBox(height: 4),
                        isLoading
                            ? const TShimmerEffect(width: 130, height: 13)
                            : Text(
                                admin.email,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                      ],
                    ),
                  const SizedBox(width: TSizes.sm),
                  if (admin.profilePicture != null &&
                      admin.profilePicture!.isNotEmpty)
                    TRoundedImage(
                      width: 40,
                      height: 40,
                      padding: 2,
                      imageType: ImageType.network,
                      image: admin.profilePicture,
                    )
                  else
                    TRoundedImage(
                      width: 40,
                      height: 40,
                      padding: 2,
                      imageType: ImageType.asset,
                      image: TImages.user,
                    ),
                ],
              );
            }),
          ]),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
