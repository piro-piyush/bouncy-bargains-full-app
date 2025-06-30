import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/admin_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
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
  Rx<AdminModel> admin = AdminModel.empty().obs;

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
  final _repo = UserRepository.instance;

  /// Init lifecycle hook — fetch user details
  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  /// 📥 Fetch logged-in user's details and populate form fields
  Future<AdminModel> fetchUserDetails() async {
    try {
      loading.value = true;

      final admin = await _repo.fetchAdmin();
      this.admin.value = admin;

      // Populate form fields
      firstNameController.text = admin.firstName;
      lastNameController.text = admin.lastName;
      emailController.text = admin.email;
      phoneController.text = admin.phoneNumber;

      return admin;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Something went wrong", message: e.toString());
      return AdminModel.empty();
    } finally {
      loading.value = false;
    }
  }

  /// 🖼️ Pick image and update profile picture in Firestore
  Future<void> updateProfilePicture() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No internet connection. Please check your connection.",
        );
      }

      loading.value = true;
      List<ImageModel>? selectedImages =
          await MediaController.instance.selectImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        final ImageModel selectedImage = selectedImages.first;

        // Update Firestore
        await _repo.updateAdminField({"ProfilePicture": selectedImage.url});

        // Update UI
        admin.value.profilePicture = selectedImage.url;
        admin.refresh();

        TLoaders.successSnackBar(
            title: "Success", message: "Profile picture updated successfully.");
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: "Update Failed", message: e.toString());
    } finally {
      loading.value = false;
    }
  }

  /// ✏️ Update first name, last name, and phone number
  Future<void> updateUserInfo() async {
    try {
      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
          title: "No Internet",
          message: "No internet connection. Please check your connection.",
        );
      }
      // Validate form
      if (!formKey.currentState!.validate()) {
        return;
      }
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final phone = phoneController.text.trim();
      // Check if all values are already the same
      final hasName = admin.value.firstName != firstName ||
          admin.value.lastName != lastName ||
          admin.value.phoneNumber != phone;
      if (!hasName) {
        TLoaders.warningSnackBar(
          title: "No Changes",
          message: "Nothing to update. All values are same.",
        );
        return;
      }
      // Assign updated values only if changed
      admin.value.firstName = firstName;
      admin.value.lastName = lastName;
      admin.value.phoneNumber = phone;
      loading.value = true;
      // Update in Firestore
      await _repo.updateAdminDetails(admin.value);
      admin.refresh();
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
