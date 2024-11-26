import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/appbar_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/chip_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/text_field_theme.dart';
import 'package:bouncy_bargain/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';


class XAppTheme {
  XAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: XColors.grey,
    brightness: Brightness.light,
    primaryColor: XColors.primary,
    textTheme: XTextTheme.lightTextTheme,
    chipTheme: XChipTheme.lightChipTheme,
    scaffoldBackgroundColor: XColors.white,
    appBarTheme: XAppBarTheme.lightAppBarTheme,
    checkboxTheme: XCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: XBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: XElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: XOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: XTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: XColors.grey,
    brightness: Brightness.dark,
    primaryColor: XColors.primary,
    textTheme: XTextTheme.darkTextTheme,
    chipTheme: XChipTheme.darkChipTheme,
    scaffoldBackgroundColor: XColors.black,
    appBarTheme: XAppBarTheme.darkAppBarTheme,
    checkboxTheme: XCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: XBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: XElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: XOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: XTextFormFieldTheme.darkInputDecorationTheme,
  );
}
