import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/device/device_utility.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XTabBar extends StatelessWidget implements PreferredSizeWidget {
  const XTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Material(
        color: dark ? XColors.black : XColors.white,
        child: TabBar(
            isScrollable: true,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            tabAlignment: TabAlignment.center,
            indicatorColor: XColors.primary,
            unselectedLabelColor: XColors.darkerGrey,
            labelColor: dark ? XColors.white : XColors.primary,
            tabs: tabs));
  }

  @override
  Size get preferredSize => Size.fromHeight(XDeviceUtils.getAppBarHeight());
}
