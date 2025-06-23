import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/extenstions.dart';
import 'base_user_model.dart';

class AdminModel extends BaseUserModel {
  bool hasBeenApproved;

  /// 🏗️ Admin model constructor
  AdminModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.email,
    required super.phoneNumber,
    super.profilePicture,
    super.createdAt,
    super.updatedAt,
    this.hasBeenApproved = false,
  }) : super(role: AppRole.admin);

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
      'HasBeenApproved': hasBeenApproved,
    };
  }

  /// 🧱 Empty admin model
  factory AdminModel.empty() => AdminModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        hasBeenApproved: false,
      );

  /// 🔄 Create from Firebase snapshot
  factory AdminModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return AdminModel.empty();
    return AdminModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      username: data['Username'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
      hasBeenApproved: data['HasBeenApproved'] ?? false,
      createdAt: data['CreatedAt']?.toDate(),
      updatedAt: data['UpdatedAt']?.toDate(),
    );
  }

  /// 🔄 Create from plain JSON
  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['Id'] ?? '',
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      username: json['Username'] ?? '',
      email: json['Email'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      profilePicture: json['ProfilePicture'],
      hasBeenApproved: json['HasBeenApproved'] ?? false,
      createdAt: json['CreatedAt'] != null
          ? (json['CreatedAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['UpdatedAt'] != null
          ? (json['UpdatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  /// ✏️ Copy with utility
  AdminModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? hasBeenApproved,
  }) {
    return AdminModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hasBeenApproved: hasBeenApproved ?? this.hasBeenApproved,
    );
  }
}
