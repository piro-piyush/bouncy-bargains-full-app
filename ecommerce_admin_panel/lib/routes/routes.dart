class TRoutes {
  static const signUp = '/sign-up';
  static const login = '/login';
  static const accountApproval = '/accountApproval';
  static const forgetPassword = '/forget-password/';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  // Category
  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  // Brands
  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  // Banners
  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  // Products
  static const products = '/products';
  static const createProduct = '/createProduct';
  static const editProduct = '/editProduct';

  // Customer
  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';

  static const coupons = '/coupons';
  static const settings = '/settings';
  static const profile = '/profile';

  static List sideMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders,
    settings,
    profile
  ];
}
