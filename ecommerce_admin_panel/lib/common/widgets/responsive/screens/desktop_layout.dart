import 'package:ecommerce_admin_panel/common/widgets/layouts/headers/header.dart';
import 'package:ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
   const DesktopLayout({super.key, this.body});

  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(child: TSidebar()),
          Expanded(
              child: Column(
            children: [
              // Header
              THeader(),

              // Body
              body ?? SizedBox(),
            ],
          ))
        ],
      ),
    );
  }
}
