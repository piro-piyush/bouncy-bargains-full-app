import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/account_approval/widgets/account_approval_widget.dart';
import 'package:flutter/material.dart';

class AccountApprovalDesktopScreen extends StatelessWidget {
  const AccountApprovalDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(child: AccountApprovalWidget());
  }
}
