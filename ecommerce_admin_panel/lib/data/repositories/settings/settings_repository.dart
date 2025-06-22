import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/settings_model.dart'
    show SettingsModel;

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Function to save setting data to firestore.
  Future<void> registerSettings(SettingsModel settings) async {
    try {
      await _db
          .collection("Settings")
          .doc("GlOBAL_SETTINGS")
          .set(settings.toMap());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  /// Function to fetch setting data based on settings id.
  Future<SettingsModel> getSettings() async {
    try {
      final snapshot =
          await _db.collection("Settings").doc("GlOBAL_SETTINGS").get();
      return SettingsModel.fromSnapshot(snapshot);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  /// Function to update setting data to firestore.
  Future<void> updateSettings(SettingsModel settings) async {
    try {
      await _db
          .collection("Settings")
          .doc("GlOBAL_SETTINGS")
          .update(settings.toMap());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Settings").doc("GlOBAL_SETTINGS").update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong. Please try again ${e.toString()}';
    }
  }
}
