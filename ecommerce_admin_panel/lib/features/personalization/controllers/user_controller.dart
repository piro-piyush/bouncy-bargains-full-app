import 'package:ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/user_model.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../media/models/image_model.dart' show ImageModel;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Obx Var
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _repo = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  /// Fetch user details from the repo
  Future<UserModel> fetchUserDetails() async {
    loading.value = true;
    try {
      final user = await _repo.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
      return UserModel.empty();
    }
  }

  void updateProfilePicture() async {
    try {
      loading.value = true;


      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the  selected image to the main logo  or perform any other action
        ImageModel selectedImage = selectedImages.first;

        await _repo.updateSingleField({
          "ProfilePicture": selectedImage.url,
        });

        // Update the main image using the selected image
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        TLoaders.successSnackBar(
            title: "Congratulations",
            message: "Profile Picture has been updated.");
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
    }
  }


  void updateUserInfo()async{
    try{
      loading.value = true;


      // Check the internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if(!formKey.currentState!.validate()){
        loading.value = false;
        return;
      }
      user.value.firstName = firstNameController.text;
      user.value.lastName = lastNameController.text;
      user.value.phoneNumber = phoneController.text;
      await _repo.updateUserDetails(user.value);
      user.refresh();
      loading.value = false;
      TLoaders.successSnackBar(
          title: "Congratulations", message: "User Details has been updated.");
    }catch(e){
      loading.value = false;
      TLoaders.errorSnackBar(
          title: "Something went wrong.", message: e.toString());
    }
  }
}
