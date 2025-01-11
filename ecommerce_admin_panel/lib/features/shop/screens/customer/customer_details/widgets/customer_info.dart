import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Information",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Personal Info Card
          Row(
            children: [
              TRoundedImage(
                imageType: ImageType.asset,
                image: TImages.user,
                padding: 0,
                backgroundColor: TColors.primaryBackground,
              ),
              SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Piyush",
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Text(
                    "piyush72717272@gmail.com",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Meta Data
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Username"),
              ),
              Text(":"),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "admin@bouncybargains",
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Country"),
              ),
              Text(":"),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "India",
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Phone Number"),
              ),
              Text(":"),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "+91 798-545-746",
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          // Divider
          Divider(),
          SizedBox(height: TSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Last Order",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("7 Days Ago, #[34d54]"),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Average Order Value",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("\$342.2"),
                ],
              )),
            ],
          ),
          SizedBox(height: TSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Registered",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(customer.formattedDate),
                ],
              )),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Marketing",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Subscribed"),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
