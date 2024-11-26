import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class XSettingsMenuTile extends StatelessWidget {
  const XSettingsMenuTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
      this.trailing, this.onTapped});

  final String title, subTitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      leading: Icon(
        icon,
        size: 28,
        color: XColors.primary,
      ),
      trailing: trailing,
      onTap: onTapped,
    );
  }
}
