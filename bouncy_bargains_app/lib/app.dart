import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bindings/general_bindings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: XTexts.appName,
        themeMode: ThemeMode.system,
        theme: XAppTheme.lightTheme,
        darkTheme: XAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        // Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
        initialBinding: GeneralBindings(),
        home: const Scaffold(
          backgroundColor: XColors.primary,
          body: Center(
            child: CircularProgressIndicator(
              color: XColors.white,
            ),
          ),
        ));
  }
}
