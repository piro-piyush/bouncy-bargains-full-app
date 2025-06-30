import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:get/get.dart';

class CreateBannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateBannerController());
  }
}