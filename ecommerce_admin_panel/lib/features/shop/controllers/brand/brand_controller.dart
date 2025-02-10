import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:get/get.dart';

class BrandController extends TBaseController<BrandModel> {
  static BrandController get instance => Get.find();
  final _repo = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containsSearchQuery(item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(item) async {
    await _repo.deleteBrand(item);
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (BrandModel b) => b.name.toLowerCase());
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch brands
    final fetchedBrands = await _repo.getAllBrands();

    // Fetch brand categories relational data
    final fetchedBrandCategories = await _repo.getAllBrandCategories();

    // Fetch all Categories is data does not already exist
    if (categoryController.allItems.isEmpty) {
      await categoryController.fetchItems();
    }

    // Loop all brands and  fetch categories for each
    for (var brand in fetchedBrands) {
      // Extract categoryIds from the documents
      List<String> categoryIds = fetchedBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();
      brand.brandCategories = categoryController.allItems
          .where((category) => categoryIds.contains(category.id))
          .toList();
    }

    return fetchedBrands;
  }

}
