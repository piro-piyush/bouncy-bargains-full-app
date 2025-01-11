import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
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
                Row(
                  children: [
                    // Tax Rate
                    Expanded(
                        child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Tax Rate (%)"),
                        hintText: "Tax %",
                        prefixIcon: Icon(Iconsax.tag),
                      ),
                    )),
                    SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),

                    // Shipping Cost
                    Expanded(
                        child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Shipping Cost (\$)"),
                        hintText: "Shipping Cost",
                        prefixIcon: Icon(Iconsax.ship),
                      ),
                      validator: (value) =>
                          TValidator.validateEmptyText("Last Name", value),
                    )),
                    SizedBox(
                      width: TSizes.spaceBtwInputFields,
                    ),

                    // Free Shipping Threshold
                    Expanded(
                        child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Free Shipping Threshold (\$)"),
                        hintText: "Free Shipping After (\$)",
                        prefixIcon: Icon(Iconsax.ship),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("Update App Settings")),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
