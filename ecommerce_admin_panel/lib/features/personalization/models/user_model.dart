import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/features/personalization/models/address_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/extenstions.dart';
import 'base_user_model.dart';

class UserModel extends BaseUserModel {
  final List<OrderModel>? orders;
  final List<AddressModel>? addresses;

  /// 🏗️ User model constructor
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.email,
    required super.phoneNumber,
    super.profilePicture,
    super.createdAt,
    super.updatedAt,
    super.role = AppRole.user,
    this.orders,
    this.addresses,
  });

  /// 🔄 Convert object to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.toJson(),
      'CreatedAt': createdAt,
      'UpdatedAt': DateTime.now(),
    };
  }

  /// 🧱 Empty user factory
  factory UserModel.empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
  );

  /// 🔄 Create from Firebase snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return UserModel.empty();

    return UserModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      username: data['Username'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'],
      role: AppRoleExtension.fromJson(data['Role'] ?? ''),
      createdAt:
      data['CreatedAt']?.toDate(),
      updatedAt:
      data['UpdatedAt']?.toDate(),
    );
  }

  /// 🧩 Create from plain JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['Id'] ?? '',
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      username: json['Username'] ?? '',
      email: json['Email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      profilePicture: json['ProfilePicture'] ?? '',
      role: AppRoleExtension.fromJson(json['Role'] ?? ''),
      createdAt:
      json['CreatedAt'] != null ? (json['CreatedAt'] as Timestamp).toDate() : null,
      updatedAt:
      json['UpdatedAt'] != null ? (json['UpdatedAt'] as Timestamp).toDate() : null,
    );
  }

  /// ✏️ Copy with utility
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    AppRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderModel>? orders,
    List<AddressModel>? addresses,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orders: orders ?? this.orders,
      addresses: addresses ?? this.addresses,
    );
  }
}
