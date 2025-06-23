import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/personalization/models/settings_model.dart';

/// ⚙️ SettingsRepository
///
/// Manages reading/writing app-wide global settings from Firestore.
/// Settings are stored under the fixed document ID `GLOBAL_SETTINGS`.
class SettingsRepository extends GetxController {
  /// Singleton access via GetX
  static SettingsRepository get instance => Get.find();

  /// Firestore instance reference
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Firestore Collections Name
  final String  settingsCollection = "Settings";

  final String  globalSettingsDoc = "GlOBAL_SETTINGS";

  //───────────────────────────────────────────────────────────────

  /// 📤 Saves initial global settings to Firestore
  ///
  /// Overwrites the `"GLOBAL_SETTINGS"` document.
  Future<void> registerSettings(SettingsModel settings) async {
    try {
      await _db
          .collection(settingsCollection)
          .doc(globalSettingsDoc)
          .set(settings.toMap());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("⚠️ registerSettings error: $e");
      throw 'Something went wrong while registering settings. Please try again.';
    }
  }

  //───────────────────────────────────────────────────────────────

  /// 📥 Fetches current global settings from Firestore
  ///
  /// Reads the `"GLOBAL_SETTINGS"` document and parses into [SettingsModel].
  Future<SettingsModel> getSettings() async {
    try {
      final snapshot = await _db.collection(settingsCollection).doc(globalSettingsDoc).get();
      return SettingsModel.fromSnapshot(snapshot);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("⚠️ getSettings error: $e");
      throw 'Something went wrong while fetching settings. Please try again.';
    }
  }

  //───────────────────────────────────────────────────────────────

  /// 🔁 Updates full settings document in Firestore
  ///
  /// Overwrites `"GLOBAL_SETTINGS"` with new values from [SettingsModel].
  Future<void> updateSettings(SettingsModel settings) async {
    try {
      await _db
          .collection(settingsCollection)
          .doc(globalSettingsDoc)
          .update(settings.toMap());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("⚠️ updateSettings error: $e");
      throw 'Something went wrong while updating settings. Please try again.';
    }
  }

  //───────────────────────────────────────────────────────────────

  /// ✏️ Updates only specific fields of the settings document
  ///
  /// Useful for partial updates like toggles, flags etc.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection(settingsCollection).doc(globalSettingsDoc).update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print("⚠️ updateSingleField error: $e");
      throw 'Something went wrong while updating settings. Please try again.';
    }
  }
}
