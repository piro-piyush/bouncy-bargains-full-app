import 'package:ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:get/get.dart';

class ProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductRepository());
    Get.put(ProductController());
    Get.put(ProductVariationsController());
    Get.put(ProductAttributesController());
    Get.put(ProductImagesController());
    Get.put(CreateProductController());
    Get.put(EditProductController());
  }
}
