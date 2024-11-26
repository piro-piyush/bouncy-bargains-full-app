import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/features/personalization/screens/address/add_new_address_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/address/widgets/single_address.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddNewAddressScreen());
        },
        backgroundColor: XColors.primary,
        child: const Icon(
          Iconsax.add,
          color: XColors.white,
        ),
      ),
      appBar: XAppBar(
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(XSizes.defaultSpace),
            child: Column(
              children: [
                XSingleAddress(
                  selectedAddress: true,
                ),
                XSingleAddress(
                  selectedAddress: false,
                ),
                XSingleAddress(
                  selectedAddress: false,
                ),
                XSingleAddress(
                  selectedAddress: false,
                ),
              ],
            )),
      ),
    );
  }
}
