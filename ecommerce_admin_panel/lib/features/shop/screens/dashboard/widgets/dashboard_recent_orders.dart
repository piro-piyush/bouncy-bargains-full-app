import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardRecentOrders extends StatelessWidget {
  const DashboardRecentOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: TSizes.spaceBtwItems,
            children: [
              TCircularIcon(
                icon: Iconsax.box,
                color: Colors.cyanAccent,
                backgroundColor: Colors.cyanAccent.withValues(alpha: 0.1),
                size: TSizes.md,
              ),
              Text(
                "Recent Orders",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
           DashboardOrderTable()
        ],
      ),
    );
  }
}