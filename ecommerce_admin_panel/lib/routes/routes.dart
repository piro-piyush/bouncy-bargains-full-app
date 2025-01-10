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

  static List sideMenuItems = [
    dashboard,
    media,
    banners,
    // products,
    categories,
    brands,
    // customers,
    // orders,
    // coupons,
    // settings
  ];
}

// static const products = '/products';

// static const createProducts = '/createProducts';
// static const editProducts = '/editProducts';

// static const customers = '/customers';

// static const createCustomer = '/createCustomer';
// static const customerDetails = '/customerDetails';

// static const orders = '/orders';

// static const responsiveDesign = '/responsiveDesign';

// static const coupons = '/coupons';
// static const settings = '/settings';
// static const logout = '/logout';
