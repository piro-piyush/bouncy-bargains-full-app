import 'package:bouncy_bargain/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:bouncy_bargain/utils/constants/text_strings.dart';
import 'package:bouncy_bargain/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
      // initialBinding: GeneralBindings(),
      home: const OnboardingScreen(),
    );
  }
}
