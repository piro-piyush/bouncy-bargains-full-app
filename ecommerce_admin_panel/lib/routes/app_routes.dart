import 'package:ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:ecommerce_admin_panel/features/media/screens/media_screen.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/profile/profile_screen.dart';
import 'package:ecommerce_admin_panel/features/personalization/screens/settings/settings_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/all_banners/banners_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/create_banner/create_banner__screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/banners/edit_banner/edit_banner__screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/all_brands/brands_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/create_brand/create_brand__screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/brands/edit_brand/edit_brand__screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/all_categories/categories_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/create_category/create_category_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/categories/edit_category/edit_category_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/all_customers/customers_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/customer/customer_details/cutomer_details_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/all_orders/orders_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/orders/order_details/order_details_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/all_products/products_screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/create_product/create_product__screen.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/products/edit_product/edit_product__screen.dart';
import 'package:ecommerce_admin_panel/routes/routes.dart';
import 'package:ecommerce_admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
      name: TRoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.media,
      page: () => const MediaScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Categories
    GetPage(
      name: TRoutes.categories,
      page: () => const CategoriesScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCategory,
      page: () => const CreateCategoryScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.editCategory,
      page: () => const EditCategoryScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Brands
    GetPage(
      name: TRoutes.brands,
      page: () => const BrandsScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBrand,
      page: () => const CreateBrandScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBrand,
      page: () => const EditBrandScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Banners
    GetPage(
      name: TRoutes.banners,
      page: () => const BannersScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBanner,
      page: () => const CreateBannerScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBanner,
      page: () => const EditBannerScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Products
    GetPage(
      name: TRoutes.products,
      page: () => const ProductsScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.createProduct,
      page: () => const CreateProductScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.editProduct,
      page: () => const EditProductScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Customers
    GetPage(
      name: TRoutes.customers,
      page: () => const CustomersScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.customerDetails,
      page: () => const CustomerDetailsScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    // Orders
    GetPage(
      name: TRoutes.orders,
      page: () => const OrdersScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.orderDetails,
      page: () => const OrderDetailsScreen(),
      middlewares: [TRoutesMiddleware()],
    ),

    GetPage(
      name: TRoutes.settings,
      page: () => const SettingsScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
    GetPage(
      name: TRoutes.profile,
      page: () => const ProfileScreen(),
      middlewares: [TRoutesMiddleware()],
    ),
  ];
}

// Coupons
// GetPage(name: TRoutes.coupons, page: () => const CouponsScreen(), middlewares: [TRoutesMiddleware()],),
