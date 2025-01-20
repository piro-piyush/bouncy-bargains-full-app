import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

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
}
