import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding:
              EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile Details",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // First And Last Name
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("First Name"),
                            hintText: "First Name",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) =>
                              TValidator.validateEmptyText("First Name", value),
                        )),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),

                        // Last Name
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Last Name"),
                            hintText: "Last Name",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                          validator: (value) =>
                              TValidator.validateEmptyText("Last Name", value),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        // Email
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                              label: Text("Email"),
                              hintText: "Email",
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false),
                        )),
                        SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        // Mobile
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Mobile"),
                            hintText: "Mobile",
                            prefixIcon: Icon(Iconsax.mobile),
                          ),
                          enabled: false,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Update Profile")),
              )
            ],
          ),
        )
      ],
    );
  }
}
