import 'package:ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    // GetPage(name: TRoutes.firstScreen, page: () => const LoginScreen() ,middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.secondScreen, page: () => const LoginScreen(),middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.secondScreenWithUID, page: () => const LoginScreen(),middlewares: [TRoutesMiddleware()],),
    
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    // GetPage(name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    // GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    // GetPage(name: TRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.media, page: () => const MediaScreen(), middlewares: [TRoutesMiddleware()],),
    //
    // // Banners
    // GetPage(name: TRoutes.banners, page: () => const BannerScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [TRoutesMiddleware()],),
    //
    // // Products
    // GetPage(name: TRoutes.products, page: () => const ProductScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createProducts, page: () => const CreateProductScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editProducts, page: () => const EditProductScreen(), middlewares: [TRoutesMiddleware()],),
    //
    // // Categories
    // GetPage(name: TRoutes.categories, page: () => const CategoryScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.createCategory, page: () => const CreateCategoryScreen(), middlewares: [TRoutesMiddleware()],),
    // GetPage(name: TRoutes.editCategory, page: () => const EditCategoryScreen(), middlewares: [TRoutesMiddleware()],),
  ];
}
