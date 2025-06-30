import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "App Settings",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                TextFormField(
                  controller: controller.appNameController,
                  decoration: InputDecoration(
                    label: Text("App Name"),
                    hintText: "App Name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                // First And Last Name
                TDeviceUtils.isMobileScreen(context)
                    ? Column(
                        spacing: TSizes.spaceBtwInputFields,
                        children: [
                          TextFormField(
                            controller: controller.taxRateController,
                            decoration: InputDecoration(
                              label: Text("Tax Rate (%)"),
                              hintText: "Tax %",
                              prefixIcon: Icon(Iconsax.tag),
                            ),
                          ),
                          TextFormField(
                            controller: controller.shippingCostController,
                            decoration: InputDecoration(
                              label: Text("Shipping Cost (\$)"),
                              hintText: "Shipping Cost",
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                "Shipping Cost", value),
                          ),
                          TextFormField(
                            controller:
                                controller.freeShippingThresholdController,
                            decoration: InputDecoration(
                              label: Text("Free Shipping Threshold (\$)"),
                              hintText: "Free Shipping After (\$)",
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        spacing: TSizes.spaceBtwInputFields,
                        children: [
                          // Tax Rate
                          Expanded(
                            child: TextFormField(
                              controller: controller.taxRateController,
                              decoration: InputDecoration(
                                label: Text("Tax Rate (%)"),
                                hintText: "Tax %",
                                prefixIcon: Icon(Iconsax.tag),
                              ),
                            ),
                          ),

                          // Shipping Cost
                          Expanded(
                            child: TextFormField(
                              controller: controller.shippingCostController,
                              decoration: InputDecoration(
                                label: Text("Shipping Cost (\$)"),
                                hintText: "Shipping Cost",
                                prefixIcon: Icon(Iconsax.ship),
                              ),
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      "Shipping Cost", value),
                            ),
                          ),

                          // Free Shipping Threshold
                          Expanded(
                            child: TextFormField(
                              controller:
                                  controller.freeShippingThresholdController,
                              decoration: InputDecoration(
                                label: Text("Free Shipping Threshold (\$)"),
                                hintText: "Free Shipping After (\$)",
                                prefixIcon: Icon(Iconsax.ship),
                              ),
                            ),
                          ),
                        ],
                      ),

                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                SizedBox(
                  width: double.infinity,
                  child: Obx(() {
                    final isLoading = controller.loading.value;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => controller.updateSettingsInfo(),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text("Update App Settings"),
                    );
                  }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
