import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransactions extends StatelessWidget {
  const OrderTransactions({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transactions",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Adjust as per your needs
          Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  TRoundedImage(
                    imageType: ImageType.asset,
                    image: TImages.paypal,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment via ${order.paymentMethod.capitalize}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      // Adjust your payment Method fee if any
                      Text(
                        "${order.paymentMethod.capitalize} fee \$25",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ))
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    "30 May 2024",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    "\$${order.totalAmount}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )),
            ],
          )
        ],
      ),
    );
  }
}
