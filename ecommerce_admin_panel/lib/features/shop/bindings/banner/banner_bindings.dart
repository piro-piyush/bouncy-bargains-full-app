import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:get/get.dart';

class BannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BannerRepository());
    Get.put(BannerController());
  }
}