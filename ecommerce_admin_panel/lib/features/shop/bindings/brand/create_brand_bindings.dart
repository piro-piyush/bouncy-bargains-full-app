import 'package:ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:get/get.dart';

class CreateBrandBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BrandRepository());
    Get.put(CreateBrandController());
  }
}