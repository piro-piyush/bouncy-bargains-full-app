import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping Address",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Meta Data
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Name"),
              ),
              Text(":"),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "Piyush",
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
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Text("Address"),
              ),
              Text(":"),
              SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Expanded(
                  child: Text(
                "B-16/1, Near Bikaner, Molarband Village, Badarpur, New Delhi - 110044",
                style: Theme.of(context).textTheme.titleMedium,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
