import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_mobile_screen.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: ResetPasswordDesktopTabletScreen(),
      mobile: ResetPasswordMobileScreen(),
    );
  }
}
