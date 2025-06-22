import 'package:ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
