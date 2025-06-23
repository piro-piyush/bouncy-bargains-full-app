import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.context,
    required this.subTitle,
    required this.growthWidget,
    required this.lastMonth,
    this.headingIcon = Iconsax.arrow_up_3,
    this.color = TColors.success,
    this.onTap,
    required this.headingIconColor,
    required this.headingBgColor,
  });

  final BuildContext context;
  final Widget growthWidget;
  final String title, subTitle, lastMonth;
  final IconData headingIcon;
  final Color color, headingIconColor, headingBgColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          // Heading
          Row(
            spacing: TSizes.spaceBtwItems,
            children: [
              TCircularIcon(icon: headingIcon,backgroundColor: headingBgColor,
              color: headingIconColor,
              size: TSizes.md,),
              TSectionHeading(
                title: title,
                textColor: TColors.textSecondary,
              ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // Right side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Indicator
                  growthWidget,
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to $lastMonth',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
