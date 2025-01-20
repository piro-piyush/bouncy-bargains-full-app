import 'package:bouncy_bargain/data/repositories/address/address_repository.dart';
import 'package:bouncy_bargain/features/personalization/models/address_model.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/helpers/network_manager.dart';
import 'package:bouncy_bargain/utils/loaders/circular_loader.dart';
import 'package:bouncy_bargain/utils/popups/full_screen_loader.dart';
import 'package:bouncy_bargain/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  // Singleton pattern for AddressController instance
  static AddressController get instance => Get.find();

  // TextEditingControllers for each field in the address form
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  // Reactive variable to trigger refresh of address data
  RxBool refreshData = true.obs;

  // Selected address
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final _repo = Get.put(AddressRepository());

  // Fetch all user-specific addresses from repository
  Future<List<AddressModel>> getAllUserAddress() async {
    try {
      final addresses = await _repo.fetchUserAddress();

      // Select the default address (if any)
      selectedAddress.value = addresses.firstWhere(
              (address) => address.selectedAddress,
          orElse: () => AddressModel.empty());

      return addresses;
    } catch (e) {
      XLoaders.errorSnackBar(
          title: "Addresses not found",
          message: e.toString());
      return [];
    }
  }

  // Select a new address as the default selected address
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Show loading dialog while updating the selected address
      Get.defaultDialog(
        title: "Updating address",
        onWillPop: () async => false,  // Disable back navigation
        barrierDismissible: false,  // Prevent closing dialog by tapping outside
        content: const XCircularLoader(),
      );

      // Deselect the current selected address (if any)
      if (selectedAddress.value.id.isNotEmpty) {
        await _repo.updateSelectedField(selectedAddress.value.id, false);
      }

      // Mark the new address as selected
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Update the repository with the newly selected address
      await _repo.updateSelectedField(newSelectedAddress.id, true);

      // Close the loading dialog
      Get.back();
    } catch (e) {
      XLoaders.errorSnackBar(
          title: "Error",
          message: e.toString());
    }
  }

  // Add a new address to the repository
  Future addNewAddress() async {
    try {
      // Show full-screen loading dialog
      XFullScreenLoader.openLoadingDialog(
          "Storing Address...", XImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Validate form inputs
      if (!addressFormKey.currentState!.validate()) {
        XFullScreenLoader.stopLoading();
        return;
      }

      // Create an AddressModel object with form data
      final address = AddressModel(
          id: "",
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);

      // Add the new address to the repository and get its ID
      final id = await _repo.addAddress(address);

      // Update the address with the new ID and set it as the selected address
      address.id = id;
      await selectAddress(address);

      // Stop the loading dialog
      XFullScreenLoader.stopLoading();

      // Show success message
      XLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your address has been saved successfully");

      // Trigger a refresh of address data
      refreshData.toggle();

      // Reset form fields
      resetFormFields();

      // Close the address form screen
      Navigator.of(Get.context!).pop();
    } catch (e) {
      XLoaders.errorSnackBar(
          title: "Oh Snap!",
          message: e.toString());
    }
  }

  // Reset all form fields to their initial state
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
