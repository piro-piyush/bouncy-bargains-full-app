import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// Page controller for the onboarding screens
  final pageController = PageController();

  /// Storage instance to manage first-time user flag
  final storage = GetStorage();

  /// Reactive variable to track the current page index
  Rx<int> currentPageIndex = 0.obs;

  /// Update the current page index when the user scrolls between pages
  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  /// Navigate to a specific page when a dot indicator is clicked
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  /// Go to the next page in the onboarding process
  void nextPage() {
    if (currentPageIndex.value == 2) {
      // When the last page is reached, set the flag to false to skip onboarding on future app launches
      storage.write('isFirstTime', false);
      Get.offAll(
          const LoginScreen()); // Redirect to Login screen after onboarding
    } else {
      // Move to the next page
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Skip the onboarding process and jump directly to the last page
  void skipPage() {
    // Set the current page to the last page and update the index
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);

    // Set the flag in storage so the onboarding doesn't show on future app launches
    storage.write('isFirstTime', false);
    Get.to(const LoginScreen()); // Redirect to Login screen
  }
}
