import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/features/personalization/controllers/address_controller.dart';
import 'package:bouncy_bargain/features/personalization/screens/address/add_new_address_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/address/widgets/single_address.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: XAppBar(
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(XSizes.defaultSpace),
            child: Column(
              children: [
                Obx(
                  () => FutureBuilder(
                      key: Key(controller.refreshData.value.toString()),
                      future: controller.getAllUserAddress(),
                      builder: (context, snapshot) {
                        final response =
                            XCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot);
                        if (response != null) return response;

                        final addresses = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: addresses.length,
                            itemBuilder: (_, index) => XSingleAddress(
                                  address: addresses[index],
                                  onTap: () => controller
                                      .selectAddress(addresses[index]),
                                ));
                      }),
                ),
              ],
            )),
      ),
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
    );
  }
}
