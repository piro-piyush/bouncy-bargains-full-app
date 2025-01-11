import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/tables/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Orders",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: "Total Spent "),
                TextSpan(
                    text: "\$340.2",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary)),
                TextSpan(
                    text: " on ${5} items",
                    style: Theme.of(context).textTheme.bodyLarge),
              ]))
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          TextFormField(
            onChanged: (query) {},
            decoration: InputDecoration(
                hintText: "Search Orders",
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          CustomerOrderTable()
        ],
      ),
    );
  }
}
