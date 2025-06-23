import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/responsive_screens/login_desktop_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/responsive_screens/login_mobile_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/sign_up/responsive_screens/sign_up_desktop_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/sign_up/responsive_screens/sign_up_mobile_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: SignUpDesktopTabletScreen(),
      mobile: SignUpMobileScreen(),
    );
  }
}
