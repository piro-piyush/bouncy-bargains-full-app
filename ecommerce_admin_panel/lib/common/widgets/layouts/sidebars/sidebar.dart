import 'package:ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:ecommerce_admin_panel/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
            color: TColors.white,
            border: Border(right: BorderSide(color: TColors.grey, width: 1))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Padding(
                padding: EdgeInsets.all(TSizes.md),
                child: Column(
                  children: [
                    Text("MENU",style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),),

                    // Menu Items
                    TMenuItem(route: TRoutes.firstScreen,icon: Iconsax.status, itemName: 'Dashboard',),
                    TMenuItem(route: TRoutes.secondScreen,icon: Iconsax.image, itemName: 'Media',),
                    TMenuItem(route: TRoutes.responsiveDesignTutorialScreen,icon: Iconsax.picture_frame, itemName: 'Banner',),
                    TMenuItem(route: TRoutes.firstScreen,icon: Iconsax.status, itemName: 'Dashboard',),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}