import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchAdminDetails();
    super.onInit();
  }

  // Fetches user details from the repository
  Future<UserModel> fetchAdminDetails() async {
    try {
      loading.value = true;
      print("Fetching admin details...");
      final fetchedUser = await userRepository.fetchAdminDetails();
      this.user.value = fetchedUser;
      print("Admin details fetched successfully: $fetchedUser");
      loading.value = false;
      return fetchedUser;
    } catch (e) {
      loading.value = false;
      // Log the error
      print("Error in fetchAdminDetails: $e");
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }
}
