import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/responsive_screens/forget_password_desktop_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/responsive_screens/forget_password_mobile_screen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: ForgetPasswordDesktopTabletScreen(),
      mobile: ForgetPasswordMobileScreen(),
    );
  }
}
