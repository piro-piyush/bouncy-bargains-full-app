import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginDesktopTabletScreen extends StatelessWidget {
  const LoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(
      child: Column(
        children: [
          // Header
          TLoginHeader(),

          // Form
          TLoginForm()
        ],
      ),
    );
  }
}
