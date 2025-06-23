import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/account_approval/responsive_screens/account_approval_desktop_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/account_approval/responsive_screens/account_approval_tablet_screen.dart';
import 'package:flutter/material.dart';

class AccountApprovalScreen extends StatelessWidget {
  const AccountApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      useLayout: false,
      desktop: AccountApprovalDesktopScreen(),
      mobile: AccountApprovalTabletScreen(),
    );
  }
}
