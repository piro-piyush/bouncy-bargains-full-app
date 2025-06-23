import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 👤 UserController
///
/// Handles the currently logged-in user's profile info.
/// - Fetches admin user details from Firestore
/// - Updates profile picture and user details
/// - Binds values to forms using GetX
class UserController extends GetxController {
  /// Singleton instance
  static UserController get instance => Get.find();

  /// Reactive loading state
  RxBool loading = false.obs;

  /// Observable user model
  Rx<UserModel> user = UserModel.empty().obs;

  /// Form key for validation
  final formKey = GlobalKey<FormState>();

  //────────────────────────────────────────────
  // Form field controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  //────────────────────────────────────────────

  /// User repository instance
  final _repo = Get.put(UserRepository());

  /// Init lifecycle hook — fetch user details
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  /// 📥 Fetch logged-in user's details and populate form fields
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;

      final admin = await _repo.fetchAdminDetails();
      user.value = admin;

      // Populate form fields
      firstNameController.text = admin.firstName;
      lastNameController.text = admin.lastName;
      emailController.text = admin.email;
      phoneController.text = admin.phoneNumber;

      return admin;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
      return UserModel.empty();
    } finally {
      loading.value = false;
    }
  }

  /// 🖼️ Pick image and update profile picture in Firestore
  Future<void> updateProfilePicture() async {
    try {
      loading.value = true;

      final mediaController = Get.put(MediaController());
      List<ImageModel>? selectedImages =
      await mediaController.selectImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        final ImageModel selectedImage = selectedImages.first;

        // Update Firestore
        await _repo.updateSingleField({"ProfilePicture": selectedImage.url});

        // Update UI
        user.value.profilePicture = selectedImage.url;
        user.refresh();

        TLoaders.successSnackBar(
            title: "Success", message: "Profile picture updated successfully.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Update Failed", message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// ✏️ Update first name, last name, and phone number
  Future<void> updateUserInfo() async {
    try {
      loading.value = true;

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate form
      if (!formKey.currentState!.validate()) {
        return;
      }

      // Assign updated values
      user.value.firstName = firstNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      // Update in Firestore
      await _repo.updateUserDetails(user.value);
      user.refresh();

      TLoaders.successSnackBar(
          title: "Success", message: "User details updated successfully.");
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
