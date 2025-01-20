import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxList<BannerModel> allItems = <BannerModel>[].obs;
  RxList<BannerModel> filteredItems = <BannerModel>[].obs;

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchController = TextEditingController();
  final _repo = Get.put(BannerRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      List<BannerModel> fetchedBanners = [];
      if (allItems.isEmpty) {
        fetchedBanners = await _repo.getAllBanners();
      }
      allItems.assignAll(fetchedBanners);
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
        return a.targetScreen
            .toLowerCase()
            .compareTo(b.targetScreen.toLowerCase());
      } else {}
      return b.targetScreen
          .toLowerCase()
          .compareTo(a.targetScreen.toLowerCase());
    });
  }

  void sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.targetScreen
            .toLowerCase()
            .compareTo(b.targetScreen.toLowerCase());
      } else {}
      return b.targetScreen
          .toLowerCase()
          .compareTo(a.targetScreen.toLowerCase());
    });
  }

  searchQuery(String query) {
    filteredItems.assignAll(allItems.where((item) =>
        item.targetScreen.toLowerCase().contains(query.toLowerCase())));
  }
}
