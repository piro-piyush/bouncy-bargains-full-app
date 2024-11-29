import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class XCircularImage extends StatelessWidget {
  const XCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = XSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Container(
      height: width,
      width: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? XColors.black : XColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        // You can remove clipRREct if there is any problem
        child: Image(
          fit: fit,
          image: isNetworkImage
              ?  NetworkImage(image)
              :  AssetImage(image) as ImageProvider,
          color: overlayColor,
        ),
      ),
    );
  }
}
