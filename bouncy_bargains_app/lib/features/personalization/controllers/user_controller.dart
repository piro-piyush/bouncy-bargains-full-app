import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/data/repositories/user/user_repository.dart';
import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:bouncy_bargain/features/personalization/models/user_model.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save User record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh the User Record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to first and Last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              username: username,
              email: userCredentials.user!.email ?? "",
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join('') : "",
              phoneNumber: userCredentials.user!.phoneNumber ?? "",
              profilePicture: userCredentials.user!.photoURL ?? "");

          // Save User Data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      XLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
    }
  }

  // Delete Account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(XSizes.md),
        title: "Delete Account",
        middleText:
            "Are you sure you want to delete your account permanently ? This action is not reversible and all your data will be removed permanently",
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: XSizes.lg),
              child: Text("Delete"),
            )),
        cancel: OutlinedButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
          },
          child: const Text("Cancel"),
        ));
  }

  // Delete  User Account
  void deleteUserAccount() async {
    try {
      XFullScreenLoader.openLoadingDialog("Processing", XImages.docerAnimation);

      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re-verify Auth Email
        if (provider == "google.com") {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          XFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == "password") {
          XFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Re - authenticate  before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      XFullScreenLoader.openLoadingDialog("Processing", XImages.docerAnimation);

      // First re-authenticate user
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Re - auth
      await AuthenticationRepository.instance
          .reAuthenticateEmailAndPasswordUser(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      XFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Upload Profile image
  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update User image Record
        Map<String, dynamic> json = {"ProfilePicture": imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        XLoaders.successSnackBar(
            title: "Congratulations",
            message: 'Your profile image has been updated');
      }
    } catch (e) {
      XLoaders.errorSnackBar(
          title: "Oh Snap", message: 'Something went wrong : $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
