import 'package:bouncy_bargain/data/repositories/user/user_repository.dart';
import 'package:bouncy_bargain/features/personalization/controllers/user_controller.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/profile_screen.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  // Singleton pattern to get the instance of UpdateNameController
  static UpdateNameController get instance => Get.find();

  // Text controllers for first name and last name input fields
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  // Repositories and controllers needed for user data
  final userRepository = Get.put(UserRepository());
  final userController = UserController.instance;

  // GlobalKey for form validation
  GlobalKey<FormState> updateUserNameKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize names when the controller is initialized
    initializeNames();
  }

  // Fetch and set the initial first and last names
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  // Update the user's name in the Firebase Firestore
  Future<void> updateUserName() async {
    try {
      // Start loading screen to indicate a process is ongoing
      XFullScreenLoader.openLoadingDialog(
          "We are updating your information", XImages.docerAnimation);

      // Check internet connectivity before proceeding
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Validate the form before proceeding
      if (!updateUserNameKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Prepare the data to update user's first and last name
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };

      // Call the repository to update the name in Firestore
      await userRepository.updateSingleField(name);

      // Update the user details in the local userController
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Stop the loading screen
      XFullScreenLoader.stopLoading();

      // Show a success message
      XLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your name has been updated');

      // Notify listeners of the updated user information
      userController.user.refresh();

      // Navigate back to the Profile screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      // Stop the loading screen if an error occurs
      XFullScreenLoader.stopLoading();

      // Show an error message
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
