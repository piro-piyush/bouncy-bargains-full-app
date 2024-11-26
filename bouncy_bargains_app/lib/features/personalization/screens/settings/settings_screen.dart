import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:bouncy_bargain/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:bouncy_bargain/common/widgets/list_tile/user_profile_tile.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/personalization/screens/address/address_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/profile_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/cart/cart_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/order/order_screen.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            XPrimaryHeaderContainer(
              child: Column(
                children: [
                  // App Bar
                  XAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: XColors.white),
                    ),
                  ),

                  // User Profile Card
                  XUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(XSizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  const XSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  XSettingsMenuTile(
                    title: "My Addresses",
                    subTitle: "Set shopping delivery address",
                    icon: Iconsax.safe_home,
                    onTapped: () {
                      Get.to(() => const AddressScreen());
                    },
                  ),
                  XSettingsMenuTile(
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    icon: Iconsax.shopping_cart,
                    onTapped: () {
                      Get.to(() => const CartScreen());
                    },
                  ),
                  XSettingsMenuTile(
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    icon: Iconsax.bag_tick,
                    onTapped: () {
                      Get.to(() => const OrderScreen());
                    },
                  ),
                  XSettingsMenuTile(
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    icon: Iconsax.bank,
                    onTapped: () {},
                  ),
                  XSettingsMenuTile(
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupons",
                    icon: Iconsax.discount_shape,
                    onTapped: () {},
                  ),
                  XSettingsMenuTile(
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    icon: Iconsax.notification,
                    onTapped: () {},
                  ),
                  XSettingsMenuTile(
                    title: "Account Privacy",
                    subTitle: "Manage data usage and connected accounts",
                    icon: Iconsax.security_card,
                    onTapped: () {},
                  ),

                  // App Settings
                  const SizedBox(
                    height: XSizes.spaceBtwSections,
                  ),
                  const XSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwItems,
                  ),

                  XSettingsMenuTile(
                    title: "Load Data",
                    subTitle: "Upload data to your Firebase",
                    icon: Iconsax.document_upload,
                    onTapped: () {},
                  ),
                  XSettingsMenuTile(
                    title: "Geolocation",
                    subTitle: "Set recommendation based on location",
                    icon: Iconsax.document_upload,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  XSettingsMenuTile(
                    title: "Safe Mode",
                    subTitle: "Search result is safe for all ages",
                    icon: Iconsax.security_user,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  XSettingsMenuTile(
                    title: "HD Image Quality",
                    subTitle: "Set image to be seen",
                    icon: Iconsax.image,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  // Logout Button
                  const SizedBox(
                    height: XSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(
                    height: XSizes.spaceBtwSections * 2.5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
