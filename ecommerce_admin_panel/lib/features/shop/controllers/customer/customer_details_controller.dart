import 'package:ecommerce_admin_panel/data/repositories/address/address_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsController extends GetxController {
  static CustomerDetailsController get instance => Get.find();

  final RxBool ordersLoading = false.obs;
  final RxBool addressLoading = false.obs;
  final RxInt sortColumnIndex = 1.obs;
  final RxBool sortAscending = true.obs;
  final RxList<bool> selectedRows = <bool>[].obs;
  final Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepo = Get.put(AddressRepository());
  final userRepo = Get.put(UserRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredOrders = <OrderModel>[].obs;


  void init(UserModel customer){
    try{
      this.customer.value = customer;
      getCustomerOrders();
      getCustomerAddresses();
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// -- Load customer Orders
  Future<void> getCustomerOrders() async {
    try {
      // Show loader while loading categories
      ordersLoading.value = true;

      // Fetch categories orders && addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await userRepo.fetchUserOrders(customer.value.id!);
      }

      // Update the categories list
      allOrders.assignAll(customer.value.orders ?? []);
      filteredOrders.assignAll(customer.value.orders ?? []);

      // Add all rows as  false [Not Selected] & toggle when required
      selectedRows.assignAll(List.generate(
          customer.value.orders != null ? customer.value.orders!.length : 0,
          (index) => false));
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  Future<void> getCustomerAddresses()async{
    try{
      addressLoading.value = true;
      if(customer.value.id != null && customer.value.id!.isNotEmpty){
        customer.value.addresses = await addressRepo.fetchUserAddresses(customer.value.id!);
      }
    }catch(e){
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }finally{
      addressLoading.value = false;
    }
  }


  void searchQuery(String query) {
    if (query.isEmpty) {
      filteredOrders.assignAll(allOrders);
    } else {
      filteredOrders.assignAll(allOrders
          .where((order) => order.toString().toLowerCase().contains(query))
          .toList());
    }
  }

  void sortById(int columnIndex, bool ascending){
    if(columnIndex == sortColumnIndex.value){
      sortAscending.value = ascending;
    }else {
      sortColumnIndex.value = columnIndex;
      sortAscending.value = ascending;
    }
  }
}
