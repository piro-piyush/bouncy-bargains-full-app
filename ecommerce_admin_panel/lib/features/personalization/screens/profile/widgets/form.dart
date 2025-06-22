import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.emailController.text = controller.user.value.email;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;

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
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                            child: TextFormField(
                          controller: controller.firstNameController,
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
                          controller: controller.lastNameController,
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
                          controller: controller.emailController,
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
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            label: Text("Mobile"),
                            hintText: "Mobile",
                            prefixIcon: Icon(Iconsax.mobile),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Obx(() {
                final isLoading = controller.loading.value;
                final widget = isLoading
                    ? const CircularProgressIndicator()
                    : Text("Update Profile");
                final onPressed =
                    isLoading ? () {} : () => controller.updateUserInfo();
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: onPressed, child: widget),
                );
              })
            ],
          ),
        )
      ],
    );
  }
}
