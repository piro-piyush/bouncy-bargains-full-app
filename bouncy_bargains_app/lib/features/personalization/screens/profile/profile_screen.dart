import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const XAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      // Body
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(XSizes.defaultSpace),
            child: Obx(
              () => Column(
                children: [
                  // Profile Picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(() {
                          if (controller.imageUploading.value) {
                            return const XShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            );
                          } else {
                            return XCircularImage(
                              padding: 0,
                              fit: BoxFit.cover,
                              image: controller.user.value.profilePicture != ""
                                  ? controller.user.value.profilePicture
                                  : XImages.user,
                              width: 80,
                              height: 80,
                              isNetworkImage:
                                  controller.user.value.profilePicture != "",
                            );
                          }
                        }),
                        TextButton(
                            onPressed: () {
                              controller.uploadProfilePicture();
                            },
                            child: Text(
                              'Change Profile Picture',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ))
                      ],
                    ),
                  ),

                  // Details
                  const SizedBox(
                    height: XSizes.spaceBtwItems / 2,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),
                  const XSectionHeading(
                    title: "Profile Information",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  XProfileMenu(
                    title: 'Name',
                    value: controller.user.value.fullName,
                    onPressed: () {
                      Get.to(() => const ChangeName());
                    },
                  ),
                  XProfileMenu(
                    title: 'Username',
                    value: controller.user.value.username,
                    onPressed: () {},
                  ),

                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  const XSectionHeading(
                    title: "Personal Information",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  XProfileMenu(
                    title: 'User ID',
                    value: controller.user.value.id,
                    onPressed: () {},
                    icon: Iconsax.copy,
                  ),
                  XProfileMenu(
                    title: 'E-mail',
                    value: controller.user.value.email,
                    onPressed: () {},
                  ),
                  XProfileMenu(
                    title: 'Phone Number',
                    value: controller.user.value.phoneNumber == ""
                        ? "Not available"
                        : controller.user.value.phoneNumber,
                    onPressed: () {},
                  ),
                  XProfileMenu(
                    title: 'Gender',
                    value: 'Male',
                    onPressed: () {},
                  ),
                  XProfileMenu(
                    title: 'Date of Birth',
                    value: '30 May, 2004',
                    onPressed: () {},
                  ),
                  const Divider(),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  Center(
                    child: TextButton(
                        onPressed: () {
                          controller.deleteAccountWarningPopup();
                        },
                        child: const Text(
                          'Close Account',
                          style: TextStyle(color: Colors.red),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
