import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
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
}
