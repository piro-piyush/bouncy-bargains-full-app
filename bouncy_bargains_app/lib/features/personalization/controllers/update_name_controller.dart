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
  static UpdateNameController get instance => Get.find();

  // Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final userController = UserController.instance;
  GlobalKey<FormState> updateUserNameKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  // Fetch User record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      XFullScreenLoader.openLoadingDialog(
          "We are updating your information", XImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserNameKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first name & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };

      await userRepository.updateSingleField(name);

      // Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remove the loader
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: 'Congratulations', message: 'You name has been updated');

      userController.user.refresh(); // Explicitly notify listeners

      // Move to previous screen
      Get.off(() => ProfileScreen());

    } catch (e) {
      // Remove the loader
      XFullScreenLoader.stopLoading();

      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
