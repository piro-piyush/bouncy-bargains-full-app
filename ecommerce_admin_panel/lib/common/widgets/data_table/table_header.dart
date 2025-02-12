import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader(
      {super.key,
      this.onPressed,
      this.buttonText = "Create",
      this.searchController,
      this.onSearchChange,
      this.showLeftWidget = true,
      this.showRightWidget = true,
      this.hintText = "Search Here ..."});

  final Function()? onPressed;
  final String buttonText;
  final String hintText;
  final bool showLeftWidget;
  final bool showRightWidget;
  final TextEditingController? searchController;
  final Function(String)? onSearchChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
          child: showLeftWidget
              ? Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: onPressed, child: Text(buttonText)),
                    )
                  ],
                )
              : SizedBox.shrink(),
        ),
        Expanded(
            flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
            child: showRightWidget
                ? TextFormField(
                    controller: searchController,
                    onChanged: onSearchChange,
                    decoration: InputDecoration(
                        hintText: hintText,
                        prefixIcon: Icon(Iconsax.search_normal)),
                  )
                : SizedBox.shrink())
      ],
    );
  }
}
