import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// Abstract method to be implemented by subclass for fetching items.
  Future<List<T>> fetchItems();

  /// Abstract method to be implemented by subclass for deleting an item.
  Future<void> deleteItem(T item);

  /// Abstract method to be implemented by subclass for checking if an item contains search query.
  bool containsSearchQuery(T item, String query);

  ///  Method for fetching lists.
  void fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
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

  /// Common method for searching bases on a query
  void searchQuery(String query) {
    filteredItems
        .assignAll(allItems.where((item) => containsSearchQuery(item, query)));
  }

  ///  Method for sorting an item to the based on property.
  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  ///  Method for adding an item to the lists.
  void addItemToList(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  ///  Method for removing an item to the lists.
  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  ///  Method for updating an item to the lists.
  void updateItemFromList(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[filteredItemIndex] = item;
  }

  ///  Method to be implemented by subclass for
  confirmAndDeleteItem(T item) {
    Get.defaultDialog(
        title: "Delete Item",
        content: Text("Are you sure you want to delete this item?"),
        confirm: SizedBox(
          width: 80,
          child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(item),
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

  ///  Method to be implemented by subclass for handling confirmation before deleting an item.
  deleteOnConfirm(T item) async {
    try {
      // Remove the Confirmation dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      await deleteItem(item);

      removeItemFromLists(item);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: "Item Deleted", message: "Your item has been deleted");
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
