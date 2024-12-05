
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class TRoutesMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    final isAuthenticated = true;
    return isAuthenticated? null: const RouteSettings(name: TRoutes.firstScreen);
  }
}