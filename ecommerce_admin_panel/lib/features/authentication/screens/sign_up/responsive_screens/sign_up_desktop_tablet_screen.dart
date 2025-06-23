import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/sign_up/widgets/sign_up_form_widget.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpDesktopTabletScreen extends StatelessWidget {
  const SignUpDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          IconButton(
              onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// Title
          Text(
            TTexts.signupTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          // Form
          SignUpFormWidget()
        ],
      ),
    );
  }
}
