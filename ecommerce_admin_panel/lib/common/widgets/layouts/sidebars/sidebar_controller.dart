import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final activeItem = TRoutes.dashboard.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activeItem.value = route;

  void changeHoverItem(String route) {
    if ((!isActive(route))) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      // Close drawer if on mobile
      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      // Check for logout
      if (route.toLowerCase() == 'logout') {
        logout(); // 👈 Your logout logic here
      } else {
        Get.toNamed(route); // 👈 Normal navigation
      }
    }
  }

  void logout()async {
    try {
      await AuthenticationRepository.instance.logoutConfirmationDialog();
      TLoaders.successSnackBar(title: "Success", message: "Log out Success !");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Error", message: e.toString());
    }
  }
}
