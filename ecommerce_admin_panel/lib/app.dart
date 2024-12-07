import 'package:ecommerce_admin_panel/bindings/general_bindings.dart';
import 'package:ecommerce_admin_panel/routes/app_routes.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: TTexts.appName,
        themeMode: ThemeMode.light,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        getPages: TAppRoute.pages,
        initialBinding: GeneralBindings(),
        initialRoute: TRoutes.dashboard,
        unknownRoute: GetPage(
            name: '/page-not-found',
            page: () => const Scaffold(
                  body: Center(
                    child: Text("Page not found"),
                  ),
                )));
  }
}
