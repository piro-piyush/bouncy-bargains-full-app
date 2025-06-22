import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends TBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _repo = Get.put(UserRepository());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (UserModel u) => u.fullName.toString().toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    return await _repo.delete(item.id ?? "");
  }

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _repo.getAllUsers();
  }
}
