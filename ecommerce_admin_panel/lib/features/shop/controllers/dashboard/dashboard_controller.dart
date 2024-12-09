import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

// order
// static final List<OrderModel> orders = [];

  @override
  void onInit() {
    _calculateWeeklySales();
    super.onInit();
  }

  void _calculateWeeklySales() {
    // Reset weekly sales to zeros
    weeklySales.value =List<double>.filled(7,0.0);
    // for(var order in orders){}
    print('Weekly sales: $weeklySales');
  }
}
