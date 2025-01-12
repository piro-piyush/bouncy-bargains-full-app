import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

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
          Text(
            "Recent Orders",
            style:
            Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          const DashboardOrderTable()
        ],
      ),
    );
  }
}