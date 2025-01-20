import 'package:bouncy_bargain/data/repositories/authentication/authentication_repository.dart';
import 'package:bouncy_bargain/features/personalization/models/address_model.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/firebase_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/format_exceptions.dart';
import 'package:bouncy_bargain/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  // Singleton instance for easier access
  static AddressRepository get instance => Get.find();

  // Firestore instance
  final _db = FirebaseFirestore.instance;

  /// Fetches the list of addresses for the authenticated user.
  ///
  /// Throws custom exceptions for different errors.
  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      // If no user is found, throw an error
      if (userId.isEmpty) {
        throw "Unable to find user information. Try again.";
      }

      // Fetch address documents from Firestore
      final result = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .get();

      // Map documents to AddressModel objects
      return result.docs
          .map((document) => AddressModel.fromSnapshot(document))
          .toList();
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth-specific errors
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      // Handle Firestore-specific errors
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      // Handle formatting issues
      throw const XFormatException();
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      throw XPlatformException(e.code).message;
    } catch (e) {
      // Handle any other errors
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Updates the `SelectedAddress` field for a specific address.
  /// [addressId] - ID of the address to update.
  /// [selected] - Boolean value indicating whether the address is selected.
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      // Update the `SelectedAddress` field in Firestore
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } on FirebaseAuthException catch (e) {
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const XFormatException();
    } on PlatformException catch (e) {
      throw XPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Adds a new address to the Firestore database.
  /// [address] - The `AddressModel` object to be added.
  /// Returns the document ID of the newly added address.
  Future<String> addAddress(AddressModel address) async {
    try {
      // Get the current user's ID
      final userId = AuthenticationRepository.instance.authUser!.uid;

      // Add the address document to Firestore
      final currentAddress = await _db
          .collection("Users")
          .doc(userId)
          .collection("Addresses")
          .add(address.toJson());

      // Return the document ID of the new address
      return currentAddress.id;
    } on FirebaseAuthException catch (e) {
      throw XFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw XFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const XFormatException();
    } on PlatformException catch (e) {
      throw XPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
