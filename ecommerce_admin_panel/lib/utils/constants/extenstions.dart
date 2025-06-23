import 'enums.dart';

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}


extension AppRoleExtension on AppRole {
  String toJson() => name;

  static AppRole fromJson(String value) {
    return AppRole.values.firstWhere(
          (e) => e.name == value,
      orElse: () => AppRole.user,
    );
  }
}
