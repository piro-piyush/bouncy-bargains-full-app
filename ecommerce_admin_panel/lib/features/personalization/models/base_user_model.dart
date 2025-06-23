import 'dart:math';

import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';
import 'package:get/get.dart';

/// 🔰 Abstract base class for shared user/admin fields.
///
/// Extend this class to create `UserModel` or `AdminModel` without repeating common logic.
abstract class BaseUserModel {
  final String id; // 🔐 Immutable Firestore document ID
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  AppRole role;
  String? profilePicture;
  DateTime createdAt;
  DateTime updatedAt;

  /// 🏗️ Base constructor with required fields
  BaseUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.role = AppRole.user,
    this.profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 🌟 Full name: 'First Last'
  String get fullName => '$firstName $lastName';

  /// 📅 Human-readable created date
  String get formattedDate => TFormatter.formatDate(createdAt);

  /// 🕒 Human-readable updated date
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  /// 📱 Format phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  /// 🔡 Split full name into words
  static List<String> nameParts(String fullName) => fullName.trim().split(" ");

  /// 🔠 Generate a stylish, readable username from full name
  static String generateUsername(String fullName) {
    final adjectives = [
      'Swift', 'Cosmic', 'Bright', 'Silent', 'Chill', 'Epic', 'Quantum',
      'Neon', 'Dark', 'Icy', 'Bold', 'Lucky', 'Rapid', 'Sunny', 'Vast',
      'Noble', 'Shiny', 'Zesty', 'Mighty'
    ];

    final nouns = [
      'Falcon', 'Nova', 'Pixel', 'Cobra', 'Dragon', 'Cloud',
      'Otter', 'Rhino', 'Tiger', 'Panda', 'Knight', 'Rocket',
      'Orca', 'Wolf', 'Eagle', 'Phoenix', 'Shadow', 'Comet',
      'Wizard', 'Vortex'
    ];

    final rand = Random();
    final first = fullName.split(" ").first.capitalize;
    final adjective = adjectives[rand.nextInt(adjectives.length)];
    final noun = nouns[rand.nextInt(nouns.length)];
    final number = rand.nextInt(9999).toString().padLeft(3, '0');

    return '$first$adjective$noun$number'; // Ex: PiyushChillPhoenix042
  }


  /// 🔁 Convert model to JSON (must be implemented by child)
  Map<String, dynamic> toJson();
}
