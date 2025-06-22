import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailsController.instance;
    // controller.getCustomerAddresses();
    return Obx(() {
      if (controller.addressLoading.value) return TLoaderAnimation();

      AddressModel selectedAddress = AddressModel.empty();
      if (controller.customer.value.addresses != null) {
        if (controller.customer.value.addresses!.isNotEmpty) {
          selectedAddress = controller.customer.value.addresses!
              .where((a) => a.selectedAddress)
              .single;
        }
      }
      return TRoundedContainer(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Address",
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
                  selectedAddress.name,
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
                  selectedAddress.country,
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
                  selectedAddress.phoneNumber,
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
                  selectedAddress.id.isNotEmpty
                      ? selectedAddress.toString()
                      : "No Address Found",
                  style: Theme.of(context).textTheme.titleMedium,
                ))
              ],
            ),
          ],
        ),
      );
    });
  }
}
