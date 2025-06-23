import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String username;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;

  // Constructor for user model
  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.orders,
    this.addresses,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  // Helper function to get full name
  String get fullName => '$firstName $lastName';

  // Helper functions to get formated created date;
  String get formattedDate => TFormatter.formatDate(createdAt);

  // Helper functions to get formated updated date;
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  // Helper function to format phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // Static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  // Static function to create an empty user model.
  static UserModel empty() => UserModel(email: '');

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
      // 'Orders': orders,
      // 'Addresses': addresses,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        username: data.containsKey('Username') ? data['Username'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        role: data.containsKey('Role')
            ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('CreatedAt')
            ? data['CreatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt')
            ? data['UpdatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
