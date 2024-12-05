import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/responsive_screens/login_desktop_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/responsive_screens/login_mobile_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: LoginDesktopTabletScreen(),
      mobile: LoginMobileScreen(),
    );
  }
}
