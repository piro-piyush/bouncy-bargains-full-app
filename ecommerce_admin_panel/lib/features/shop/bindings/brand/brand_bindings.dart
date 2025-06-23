import 'package:ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:get/get.dart';

class BrandBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BrandRepository());
    Get.put(CategoryRepository());
    Get.put(CategoryController());
    Get.put(BrandController());
  }
}