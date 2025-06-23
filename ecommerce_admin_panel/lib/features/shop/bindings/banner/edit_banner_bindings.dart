import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/edit_banner_controller.dart';
import 'package:get/get.dart';

class EditBannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BannerRepository());
    Get.put(EditBannerController());
  }
}
