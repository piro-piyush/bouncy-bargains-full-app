import 'package:bouncy_bargain/common/widgets/images/x_circular_image.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class XUserProfileTile extends StatelessWidget {
  const XUserProfileTile({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const XCircularImage(
        image: XImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        "Piyush",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: XColors.white),
      ),
      subtitle: Text(
        "user@gmail.com",
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: XColors.white),
      ),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Iconsax.edit,
            color: XColors.white,
          )),
    );
  }
}
