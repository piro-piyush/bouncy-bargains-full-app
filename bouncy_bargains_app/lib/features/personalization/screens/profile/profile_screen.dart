import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const XAppBar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const XCircularImage(
                      image: XImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
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
                value: 'Piyush',
                onPressed: () {},
              ),
              XProfileMenu(
                title: 'Username',
                value: 'piiiyuuu.sh',
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
                value: '72717272  ',
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              XProfileMenu(
                title: 'E-mail',
                value: 'user@mail.com',
                onPressed: () {},
              ),
              XProfileMenu(
                title: 'Phone Number',
                value: '+91-223-332-3322',
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
                    onPressed: () {},
                    child: const Text(
                      'Close Account',
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
