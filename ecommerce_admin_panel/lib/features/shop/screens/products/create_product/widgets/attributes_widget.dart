import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:ecommerce_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? Column(
            children: [
              Divider(
                color: TColors.primaryBackground,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          )
              : SizedBox.shrink();
        }),

        Text(
          'Add Product Attributes',
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Form to add new attributes
        Form(
            key: attributeController.attributeFormKey,
            child: TDeviceUtils.isDesktopScreen(context)
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAttributeName(attributeController),
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Expanded(
                    flex: 2,
                    child: _buildAttributeTextField(attributeController)),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                _buildAttributeButton(attributeController)
              ],
            )
                : Column(
              children: [
                _buildAttributeName(attributeController),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                _buildAttributeTextField(attributeController),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                _buildAttributeButton(attributeController)
              ],
            )),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // List of added attributes
        Text(
          "All Attributes",
          style: Theme
              .of(context)
              .textTheme
              .headlineSmall,
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        // Display added attributes in a rounded container
        Obx(() {
          return TRoundedContainer(
            backgroundColor: TColors.primaryBackground,
            child: attributeController.productAttributes.isNotEmpty
                ? buildAttributesList(context, attributeController)
                : buildEmptyAttributes(),
          );
        }),
        SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        // Generate Variations Button
        Obx(() =>
        productController.productType.value == ProductType.variable &&
            variationController.productVariations.isEmpty
            ? Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () =>
                  variationController
                      .generateVariationsConfirmation(context),
              label: Text("Generate Variations"),
              icon: Icon(Iconsax.activity),
            ),
          ),
        )
            : SizedBox.shrink())
      ],
    );
  }

  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeNameController,
      validator: (value) =>
          TValidator.validateEmptyText("Attributes Name", value),
      decoration: InputDecoration(
          labelText: "Attribute Name", hintText: "Colors, Sizes, Material"),
    );
  }

  SizedBox _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller.attributeValueController,
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

  SizedBox _buildAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
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

  ListView buildAttributesList(BuildContext context, ProductAttributesController controller) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
          child: ListTile(
            title: Text(controller.productAttributes[index].name ?? ""),
            subtitle: Text(controller.productAttributes[index].values!
                .map((e) => e.trim())
                .toString()),
            trailing: IconButton(
                onPressed: () => controller.removeAttribute(index, context),
                icon: Icon(
                  Iconsax.trash,
                  color: TColors.error,
                )),
          ),
        );
      },
      separatorBuilder: (_, __) =>
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
      itemCount: controller.productAttributes.length,
      shrinkWrap: true,
    );
  }
}
