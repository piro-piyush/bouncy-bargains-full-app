import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class XShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: XColors.darkerGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
      color: XColors.darkerGrey.withOpacity(0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}
