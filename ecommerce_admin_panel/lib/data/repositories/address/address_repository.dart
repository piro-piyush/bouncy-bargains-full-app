import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch User Address from firestore based on User Id
  Future<List<AddressModel>> fetchUserAddresses(String id) async {
    try {
      final querySnapshot = await _db.collection("Users").doc(id).collection(
          "Addresses").get();
      return querySnapshot.docs
          .map((user) => AddressModel.fromSnapshot(user))
          .toList();
    } catch (e) {
      // Throw an error if fetching address fails
      throw "Something went wrong while fetching Address Information. Try again later.";
    }
  }

  // Update the selectedAddress field for a specific user
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Get the  current users id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      // Update the selected field for the specific address in firestore
      await _db.collection("Users").doc(userId).collection("Addresses").doc(
          addressId).update({
        "SelectedAddress": selected
      });
    } catch (e) {
      throw "Unable to update your address Information. Try again later.";
    }
  }


  // Add a new address to FireStore
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw "Unable to update your address Information. Try again later.";
    }
  }
}