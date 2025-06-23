import 'package:ecommerce_admin_panel/features/authentication/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AccountApprovalWidget extends StatelessWidget {
  AccountApprovalWidget({super.key});

  final controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.lock, size: 64, color: Colors.orange),
          const SizedBox(height: TSizes.spaceBtwItems),

          Image(
            image: AssetImage(TImages.pendingVerificationIllustration),
            height: 200,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Text(
            "Your account has not been approved yet.",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          Text(
            "Please wait for admin approval to access the app.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // 🔄 Check Approval
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.checkApproval(),
              child: const Text("Check Approval Status"),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // 🚪 Logout
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Get.offAllNamed(TRoutes.login),
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
