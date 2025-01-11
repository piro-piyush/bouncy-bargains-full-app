import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: TColors.primaryBackground,
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Form to add new attributes
        Form(
            child: TDeviceUtils.isDesktopScreen(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildAttributeNames(),
                      ),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(flex: 2, child: _buildAttributeTextField()),
                      SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      _buildAttributeButton()
                    ],
                  )
                : Column(
                    children: [
                      _buildAttributeNames(),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      _buildAttributeTextField(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      _buildAttributeButton()
                    ],
                  )),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // List of added attributes
        Text(
          "All Attributes",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Display added attributes in a rounded container
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttributes(),
            ],
          ),
        ),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Generate Variations Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text("Generate Variations"),
              icon: Icon(Iconsax.activity),
            ),
          ),
        )
      ],
    );
  }

  TextFormField _buildAttributeNames() {
    return TextFormField(
      validator: (value) =>
          TValidator.validateEmptyText("Attributes Name", value),
      decoration: InputDecoration(
          labelText: "Attribute Name", hintText: "Colors, Sizes, Material"),
    );
  }

  SizedBox _buildAttributeTextField() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            TValidator.validateEmptyText("Attributes Field", value),
        decoration: InputDecoration(
          labelText: "Attributes",
          hintText:
              "Add attributes separated by | Example: Green | Blue | Yellow",
        ),
      ),
    );
  }

  SizedBox _buildAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text(
          "Add",
        ),
        icon: Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: TColors.secondary,
            side: BorderSide(color: TColors.secondary)),
      ),
    );
  }

  Column buildEmptyAttributes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
              imageType: ImageType.asset,
              width: 150,
              height: 80,
              image: TImages.defaultAttributeColorsImageIcon,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Text("There are no attributes added for this product"),
      ],
    );
  }

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          child: ListTile(
            title: Text("Color"),
            subtitle: Text("Green, Orange, Pink"),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.trash,
                  color: TColors.error,
                )),
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(
        height: TSizes.spaceBtwItems,
      ),
      itemCount: 3,
      shrinkWrap: true,
    );
  }
}
