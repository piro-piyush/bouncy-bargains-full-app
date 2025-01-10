import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.searchController,
      this.onSearchChange});

  final Function()? onPressed;
  final String buttonText;
  final TextEditingController? searchController;
  final Function(String)? onSearchChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: TDeviceUtils.isDesktopScreen(context) ? 3 : 1,
            child: Row(
          children: [
            SizedBox(
              width: 200,
              child:
                  ElevatedButton(onPressed: onPressed, child: Text(buttonText)),
            )
          ],
        )),
        Expanded(
            flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
            child: TextFormField(
              controller: searchController,
              onChanged: onSearchChange,
              decoration: InputDecoration(
                  hintText: "Search Here ...",
                  prefixIcon: Icon(Iconsax.search_normal)),
            ))
      ],
    );
  }
}
