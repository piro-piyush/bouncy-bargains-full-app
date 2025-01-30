import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchController = TextEditingController();
  final _repo = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _repo.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {}
      return b.name.toLowerCase().compareTo(a.name.toLowerCase());
    });
  }

  void sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {}
      return b.name.toLowerCase().compareTo(a.name.toLowerCase());
    });
  }

  searchQuery(String query) {
    filteredItems.assignAll(allItems.where(
        (item) => item.name.toLowerCase().contains(query.toLowerCase())));
  }

  confirmAndDeleteItem(CategoryModel category) {
    Get.defaultDialog(
        title: "Delete Item",
        content: Text("Are you sure you want to delete this item?"),
        confirm: SizedBox(
          width: 80,
          child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(category),
            style: OutlinedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(TSizes.buttonRadius * 5))),
            child: Text("Confirm"),
          ),
        ),
        cancel: SizedBox(
          width: 80,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
                padding:
                    EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(TSizes.buttonRadius * 5))),
            child: Text("Cancel"),
          ),
        ));
  }

  deleteOnConfirm(CategoryModel category) async {
    try {
      // Remove the Confirmation dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      await _repo.deleteCategory(categoryId: category.id);
      removeItemFromLists(category);
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Item Deleted", message: "Your item has been deleted");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Method for removing item from the lists.
  void removeItemFromLists(CategoryModel category) {
    allItems.remove(category);
    filteredItems.remove(category);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));

    update();
  }

  /// Method for adding item to the lists.
  void addItemToList(CategoryModel category) {
    allItems.add(category);
    filteredItems.add(category);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));

    filteredItems.refresh();
  }

  /// Method for updating item in the lists.
  void updateItemInList(CategoryModel category) {
    final itemIndex = allItems.indexWhere((i) => i == category);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == category);

    if (itemIndex != -1) allItems[itemIndex] = category;
    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = category;

    filteredItems.refresh();
  }
}
