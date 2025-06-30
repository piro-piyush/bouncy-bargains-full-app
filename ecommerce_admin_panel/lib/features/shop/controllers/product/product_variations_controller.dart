import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductVariationsController extends GetxController {
  static ProductVariationsController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  // List to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllersList = [];

  final attributeController =ProductAttributesController.instance;

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] = TextEditingController(
        text: variation.stock.toString(),
      );
      stockControllersList.add(stockControllers);

      // Price controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] = TextEditingController(
        text: variation.price.toString(),
      );
      priceControllersList.add(priceControllers);

      // Sale Price controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers =
          {};
      salePriceControllers[variation] = TextEditingController(
        text: variation.salePrice.toString(),
      );
      salePriceControllersList.add(salePriceControllers);

      // Description controllers
      Map<ProductVariationModel, TextEditingController> descriptionControllers =
          {};
      descriptionControllers[variation] = TextEditingController(
        text: variation.description,
      );
      descriptionControllersList.add(descriptionControllers);
    }
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate Variations',
      title: 'Generate Variations',
      content:
          'Once the variations are created, you cannot add more attributes. In order to add more variations, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  void removeVariation(BuildContext context) {
    TDialogs.defaultDialog(
        context: context,
        title: 'Remove Variation',
        content: 'Are you sure you want to remove this variation?',
        onConfirm: () {
          productVariations.value = [];
          resetAllValues();
          Navigator.of(context).pop();
        });
  }

  void generateVariationsFromAttributes() {
    // CLose the  previous popup
    Get.back();

    final List<ProductVariationModel> variations = [];

    // Check if there are attributes
    if (attributeController.productAttributes.isNotEmpty) {
      // Get all combinations of  attribute values, [[Green, Blue], [Small, Large]]
      final List<List<String>> attributeCombinations = getCombinations(
          attributeController.productAttributes
              .map((e) => e.values ?? <String>[])
              .toList());

      // Generate variations for each combination
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
            attributeController.productAttributes
                .map((attr) => attr.name ?? ""),
            combination);

        // You can se the default values for other properties if needed
        final ProductVariationModel variation = ProductVariationModel(
            id: UniqueKey().toString(), attributeValues: attributeValues);

        variations.add(variation);

        // Create Controllers for each variation
        final Map<ProductVariationModel, TextEditingController>
            stockControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            priceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        // Assuming variation is your current variation
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // Add the maps to their respective lists
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);
      }
    }
    // Assign the generated variations to the productVariations list
    productVariations.assignAll(variations);
  }

  void combine(List<List<String>> lists, int index, List<String> current,
      List<List<String>> result) {
    // if we have reached the end of the lists , add the combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    // Iterate over the values of the current attribute
    for (final item in lists[index]) {
      // Create an updated lists with the current value added
      final List<String> updated = List.from(current)..add(item);

      // Recursively combine the next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  void resetAllValues() {
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    // The result list that will store all combinations
    final List<List<String>> result = [];

    // Start combining attributes from the first attribute
    combine(lists, 0, <String>[], result);

    // Return the final list of combinations
    return result;
  }
}
