import 'package:ecommerce_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordDesktopTabletScreen extends StatelessWidget {
  const ForgetPasswordDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TLoginTemplate(child: HeaderAndForm());
  }
}
