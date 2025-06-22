import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();


  // Obx for loading state , form key , and product attributes
  final isLoading = false.obs;
  final attributeFormKey = GlobalKey<FormState>();
  TextEditingController attributeNameController = TextEditingController();
  TextEditingController attributeValueController = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes = <ProductAttributeModel>[].obs;

  // Function to add a new attribute
  void addNewAttribute() {
    // Form validation
    if (!attributeFormKey.currentState!.validate()) {
      return;
    }
    // Add Attribute to the list of attributes
    productAttributes.add(ProductAttributeModel(
        name: attributeNameController.text.trim(),
        values: attributeValueController.text.trim().split('|').toList()));

    // Clear the text fields
    attributeNameController.text = "";
    attributeValueController.text = "";
  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context) {
    // Show a confirmation dialog
    TDialogs.defaultDialog(
        context: context,
        onConfirm: () {
          // User confirmed, remove the attribute
          Navigator.of(context).pop();
          productAttributes.removeAt(index);

          // Reset productVariations when removing an attribute
          ProductVariationsController.instance.productVariations.value = [];
        });
  }

  // Function to reset the list of attributes
  void resetProductAttributes() {
    productAttributes.clear();
  }
}
