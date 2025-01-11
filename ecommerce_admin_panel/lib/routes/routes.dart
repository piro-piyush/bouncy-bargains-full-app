class TRoutes {
  static const login = '/login';
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
  static const customer = '/customer';
  static const customers = '/customers';

  static const orders = '/orders';
  static const ordersDetails = '/ordersDetails';

  static const coupons = '/coupons';
  static const settings = '/settings';
  static const logout = '/logout';

  static List sideMenuItems = [
    dashboard,
    media,
    banners,
    products,
    categories,
    brands,
    customers,
    orders,
    coupons,
    settings
  ];
}
