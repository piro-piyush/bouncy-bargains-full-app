import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({
    super.key,
    this.onPressed,
    this.buttonText = "Create",
    this.searchController,
    this.onSearchChange,
    this.showLeftWidget = true,
    this.showRightWidget = true,
    this.hintText = "Search Here ...",
  });

  final Function()? onPressed;
  final String buttonText;
  final String hintText;
  final bool showLeftWidget;
  final bool showRightWidget;
  final TextEditingController? searchController;
  final Function(String)? onSearchChange;

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    if (isDesktop) {
      // 💻 Desktop layout
      return Row(
        children: [
          if (showLeftWidget)
            Expanded(
              flex: 3,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ),
              ),
            ),
          if (showRightWidget)
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchChange,
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
            ),
        ],
      );
    } else {
      // 📱 Tablet layout: Stacked vertically with spacing
      return Row(
        children: [
          if (showLeftWidget)
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(buttonText),
                  ),
                ),
              ),
            ),
          if (showRightWidget)
            SizedBox(
              width: 12,
            ),
          if (showRightWidget)
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchChange,
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
            ),
        ],
      );
    }
    // } else {
    //   // 📱 Mobile layout: Full width elements with vertical stack
    //   return Row(
    //     children: [
    //       if (showLeftWidget)
    //         ElevatedButton(
    //           onPressed: onPressed,
    //           child: Text(buttonText),
    //         ),
    //       if (showRightWidget)
    //         SizedBox(
    //           width: 12,
    //         ),
    //       if (showRightWidget)
    //         TextFormField(
    //           controller: searchController,
    //           onChanged: onSearchChange,
    //           decoration: InputDecoration(
    //             hintText: hintText,
    //             prefixIcon: Icon(Iconsax.search_normal),
    //           ),
    //         ),
    //     ],
    //   );
  }
}
