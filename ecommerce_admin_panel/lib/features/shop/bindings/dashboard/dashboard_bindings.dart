import 'package:ecommerce_admin_panel/data/repositories/address/address_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/order/order_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository());
    Get.put(OrderRepository());
    Get.put(AddressRepository());
    Get.put(OrderController());
    Get.put(CustomerController());
    Get.put(CustomerDetailsController());
    Get.put(DashboardController());
  }
}