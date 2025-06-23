import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

/// 👥 CustomerController
/// - Handles fetching, searching, sorting, and deleting users (customers).
/// - Inherits from [TBaseController] for DataTable integration.
class CustomerController extends TBaseController<UserModel> {
  /// Singleton instance for global access
  static CustomerController get instance => Get.find();

  /// 📦 User repository for CRUD operations
  final UserRepository _repo = Get.put(UserRepository());

  /// 🔍 Filters user list based on search query (matches full name)
  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  /// 🔠 Sort customers by full name
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
          (UserModel u) => u.fullName.toLowerCase(),
    );
  }

  /// ❌ Deletes a user from Firestore using their ID
  @override
  Future<void> deleteItem(UserModel item) async {
    return await _repo.deleteUser(item.id);
  }

  /// 📥 Fetches all users from Firestore
  @override
  Future<List<UserModel>> fetchItems() async {
    return await _repo.getAllUsers();
  }
}
