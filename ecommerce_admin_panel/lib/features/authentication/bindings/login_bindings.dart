import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/forget_password_controller.dart';
import 'package:ecommerce_admin_panel/features/authentication/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsRepository());
    Get.put(UserRepository());
    Get.put(LoginController());
    Get.put(ForgetPasswordController());
  }
}