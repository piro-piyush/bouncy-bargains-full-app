import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsRepository());
    Get.put(UserRepository());
    Get.put(AuthController());
  }
}