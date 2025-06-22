import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/tables/data_table.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailsController.instance;
    // controller.getCustomerOrders();
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Obx(() {
        if (controller.ordersLoading.value) {
          return TLoaderAnimation();
        }
        if (controller.allOrders.isEmpty) {
          return TAnimationLoaderWidget(
            text: "No Orders Found",
            animation: TImages.pencilAnimation,
          );
        }
        final totalAmount = controller.allOrders.fold(0.0, (p,e)=>p+e.totalAmount);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Orders",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "Total Spent "),
                  TextSpan(
                      text: "\$${totalAmount.toString()}}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: TColors.primary)),
                  TextSpan(
                      text: " on ${controller.allOrders.length} items",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge),
                ]))
              ],
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (query)=>controller.searchQuery(query),
              decoration: InputDecoration(
                  hintText: "Search Orders",
                  prefixIcon: Icon(Iconsax.search_normal)),
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            CustomerOrderTable()
          ],
        );
      }),
    );
  }
}
