import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = UserController.instance;
    return Scaffold(
      appBar: XAppBar(title: Text('Change Name',style: Theme.of(context).textTheme.headlineSmall,),showBackArrow: true,),
      body: Padding(padding: const EdgeInsets.all(XSizes.defaultSpace),child: Column(
        children: [
          // Headings
          const Text("Use real name for easy verification. This name will appear on several pages,"),
          const SizedBox(height: XSizes.spaceBtwSections,),

          // Text field and button
          Form(child: Column(
            children: [
              TextFormField(
                // controller: controller.firstName,
                validator: (value) =>XValidator.validateEmptyText('First name', value),
                expands: false,
                decoration: const InputDecoration(labelText: XTexts.firstName,prefixIcon: Icon(Iconsax.user)),
              ),const SizedBox(height: XSizes.spaceBtwItems,),

              TextFormField(
                validator: (value) =>XValidator.validateEmptyText('Last name', value),
                expands: false,
                decoration: const InputDecoration(labelText: XTexts.lastName,prefixIcon: Icon(Iconsax.user)),
              ),
            ],
          )),
          const SizedBox(height: XSizes.spaceBtwSections,),

          // Save Button
          SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text("Save")),)
        ],
      ),
      ),
    );
  }
}
