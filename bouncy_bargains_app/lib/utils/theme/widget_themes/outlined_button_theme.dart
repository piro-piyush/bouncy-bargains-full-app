import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class XOutlinedButtonTheme {
  XOutlinedButtonTheme._();

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: XColors.dark,
      side: const BorderSide(color: XColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: XColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: XSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(XSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: XColors.light,
      side: const BorderSide(color: XColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: XColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: XSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(XSizes.buttonRadius)),
    ),
  );
}
