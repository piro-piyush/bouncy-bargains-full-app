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

  // Observables
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;

  // Controllers for re-authentication
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();

  // Repository instances
  final userRepository = Get.put(UserRepository());

  // GlobalKey for re-authentication form
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Fetch the user's details when the controller is initialized
    fetchUserRecord();
  }

  // Fetch user record from Firestore
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user); // Update the Rx user value
    } catch (e) {
      // In case of error, set user to empty model
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user record during registration or login from a provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Fetch user details after saving
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Extract first and last name from display name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          // Map data to the UserModel
          final user = UserModel(
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? "",
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : "",
            phoneNumber: userCredentials.user!.phoneNumber ?? "",
            profilePicture: userCredentials.user!.photoURL ?? "",
          );

          // Save the user data to Firestore
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      // Show error message in case of failure
      XLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your profile.');
    }
  }

  // Show delete account confirmation dialog
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(XSizes.md),
      title: "Delete Account",
      middleText:
          "Are you sure you want to delete your account permanently? This action is irreversible.",
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: XSizes.lg),
          child: Text("Delete"),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () {
          Navigator.of(Get.overlayContext!).pop();
        },
        child: const Text("Cancel"),
      ),
    );
  }

  // Delete user account
  void deleteUserAccount() async {
    try {
      XFullScreenLoader.openLoadingDialog("Processing", XImages.docerAnimation);

      // Re-authenticate user based on their provider (Google or password)
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == "google.com") {
          // If Google provider, sign in again and delete account
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          XFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == "password") {
          // If password provider, re-authenticate with email and password
          XFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      // Handle any errors during account deletion
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Re-authenticate user with email and password
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      XFullScreenLoader.openLoadingDialog("Processing", XImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Validate the re-authentication form
      if (!reAuthFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Perform re-authentication and delete account
      await AuthenticationRepository.instance
          .reAuthenticateEmailAndPasswordUser(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      XFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      // Handle errors during re-authentication and deletion
      XFullScreenLoader.stopLoading();
      XLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  // Upload profile picture
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
        // Upload image and get the URL
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        // Update user profile picture in Firestore
        Map<String, dynamic> json = {"ProfilePicture": imageUrl};
        await userRepository.updateSingleField(json);

        // Update the local user model
        user.value.profilePicture = imageUrl;
        user.refresh();

        // Show success message
        XLoaders.successSnackBar(
          title: "Congratulations",
          message: 'Your profile image has been updated',
        );
      }
    } catch (e) {
      // Handle errors during image upload
      XLoaders.errorSnackBar(
          title: "Oh Snap", message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
