import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/features/personalization/controllers/address_controller.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: const XAppBar(
        title: Text('Add new Address'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      XValidator.validateEmptyText("Name", value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(
                  height: XSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) =>
                      XValidator.validateEmptyText('Phone Number', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.mobile),
                      labelText: 'Phone Number'),
                ),
                const SizedBox(
                  height: XSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            XValidator.validateEmptyText('Street', value),
                        controller: controller.street,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building_31),
                            labelText: 'Street'),
                      ),
                    ),
                    const SizedBox(
                      width: XSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) =>
                            XValidator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.code),
                            labelText: 'Postal Code'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: XSizes.spaceBtwInputFields,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) =>
                            XValidator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.building),
                            labelText: 'City'),
                      ),
                    ),
                    const SizedBox(
                      width: XSizes.spaceBtwInputFields,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            XValidator.validateEmptyText('State', value),
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.activity),
                            labelText: 'State'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: XSizes.spaceBtwInputFields,
                ),
                TextFormField(
                  controller: controller.country,
                  validator: (value) =>
                      XValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.global), labelText: 'Country'),
                ),
                const SizedBox(
                  height: XSizes.defaultSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.addNewAddress();
                      },
                      child: const Text('Save')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
