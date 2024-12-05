import 'package:ecommerce_admin_panel/common/styles/spacing_styles.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg)),
          child: Column(
            children: [
              // Header
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Image(
                      width: 100,
                      height: 100,
                      image: AssetImage(TImages.darkAppLogo),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    Text(
                      TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: TSizes.sm,
                    ),
                    Text(
                      TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              // Form
              Form(
                  child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: TTexts.email,
                      ),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),

                    // Password
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: TTexts.password,
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: Icon(Iconsax.eye_slash))),
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields / 2,
                    ),

                    // Remember Me & forget password
                    Row(
                      children: [
                        // Remember me
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(value: false, onChanged: (value) {}),
                            Text(TTexts.rememberMe),
                          ],
                        ),

                        // Forget Password
                        TextButton(
                            onPressed: () {},
                            child: Text(TTexts.forgetPassword))
                      ],
                    ),

                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text(TTexts.signIn)),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
