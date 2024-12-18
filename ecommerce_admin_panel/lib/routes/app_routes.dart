import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/banners_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/categories_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/coupons/coupons_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customers/customers_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/media/media_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/orders_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/products_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/settings/settings_screen.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [TRoutesMiddleware()],),
    GetPage(name: TRoutes.media, page: () => const MediaScreen(), middlewares: [TRoutesMiddleware()],),

    // Banners
    GetPage(name: TRoutes.banners, page: () => const BannersScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [TRoutesMiddleware()],),

    // Products
    GetPage(name: TRoutes.products, page: () => const ProductsScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createProducts, page: () => const CreateProductScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editProducts, page: () => const EditProductScreen(), middlewares: [TRoutesMiddleware()],),

    // Categories
    GetPage(name: TRoutes.categories, page: () => const CategoriesScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createCategory, page: () => const CreateCategoryScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editCategory, page: () => const EditCategoryScreen(), middlewares: [TRoutesMiddleware()],),

    // Brands
    GetPage(name: TRoutes.banners, page: () => const BannersScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createCategory, page: () => const CreateCategoryScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editCategory, page: () => const EditCategoryScreen(), middlewares: [TRoutesMiddleware()],),

    // Customers
    GetPage(name: TRoutes.customers, page: () => const CustomersScreen(), middlewares: [TRoutesMiddleware()],),

    // Orders
    GetPage(name: TRoutes.orders, page: () => const OrdersScreen(), middlewares: [TRoutesMiddleware()],),

    // Coupons
    GetPage(name: TRoutes.coupons, page: () => const CouponsScreen(), middlewares: [TRoutesMiddleware()],),

    // Settings
    GetPage(name: TRoutes.settings, page: () => const SettingsScreen(), middlewares: [TRoutesMiddleware()],),

    // // Logout
    // GetPage(name: TRoutes.logout, page: () => const OrdersScreen(), middlewares: [TRoutesMiddleware()],),
  ];
}
