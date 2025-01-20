import 'package:bouncy_bargain/features/authentication/screens/login/login_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/password_configuration/forget_password_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/password_configuration/reset_password_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/signup_screen.dart';
import 'package:bouncy_bargain/features/authentication/screens/signup/verify_email_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/profile/profile_screen.dart';
import 'package:bouncy_bargain/features/personalization/screens/settings/settings_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/all_products/all_products_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/favourite/favourite_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/home/home_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_details/product_details_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/product/product_reviews/product_reviews_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/store/store_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/order/order_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/cart/cart_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/checkout/checkout_screen.dart';
import 'package:bouncy_bargain/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: XRoutes.home, page: () => const HomeScreen()),
    GetPage(name: XRoutes.store, page: () => const StoreScreen()),
    GetPage(name: XRoutes.favourites, page: () => const FavouriteScreen()),
    // GetPage(name: XRoutes.search, page: () => SearchScreen()),
    GetPage(
        name: XRoutes.productReviews, page: () => const ProductReviewsScreen()),
    GetPage(
        name: XRoutes.productDetail, page: () => const ProductDetailsScreen()),
    GetPage(name: XRoutes.order, page: () => const OrderScreen()),
    GetPage(name: XRoutes.cart, page: () => const CartScreen()),
    // GetPage(name: XRoutes.brand, page: () => BrandScreen()),
    GetPage(name: XRoutes.allProducts, page: () => const AllProductsScreen()),
    GetPage(name: XRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: XRoutes.signup, page: () => const SignupScreen()),
    // GetPage(name: XRoutes.signupSuccess, page: () => SignupSuccessScreen()),
    GetPage(name: XRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: XRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: XRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: XRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: XRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: XRoutes.settings, page: () => const SettingsScreen()),
    // GetPage(name: XRoutes.userAddress, page: () => UserAddressScreen()),
    GetPage(name: XRoutes.checkout, page: () => const CheckoutScreen()),
  ];
}
