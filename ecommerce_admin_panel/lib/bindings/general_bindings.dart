import 'package:get/get.dart';
import 'package:ecommerce_admin_panel/utils/helpers/network_manager.dart';

// Repositories
import 'package:ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/media/media_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/order/order_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:ecommerce_admin_panel/data/repositories/address/address_repository.dart';

// Controllers
import 'package:ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/banner_controllers.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/create_banner_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/banner/edit_banner_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/create_category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/customer/customer_details_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // 🧠 Core
    Get.lazyPut(() => NetworkManager(),fenix: true);

    // 🔐 Repositories (lazy with fenix is enough)
    Get.lazyPut(() => AddressRepository(), fenix: true);
    Get.lazyPut(() => MediaRepository(), fenix: true);
    Get.lazyPut(() => CategoryRepository(), fenix: true);
    Get.lazyPut(() => BrandRepository(), fenix: true);
    Get.lazyPut(() => ProductRepository(), fenix: true);
    Get.lazyPut(() => OrderRepository(), fenix: true);
    Get.lazyPut(() => BannerRepository(), fenix: true);
    Get.lazyPut(() => SettingsRepository(), fenix: true);

    // 👤 Personalization
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);

    // 📸 Media (used in multiple screens)
    Get.lazyPut(() => MediaController(), fenix: true);

    // 📦 Category (used in product, brand etc.)
    Get.lazyPut(() => CategoryController(), fenix: true);
    Get.lazyPut(() => CreateCategoryController());
    Get.lazyPut(() => EditCategoryController());

    // 🏷️ Brand (used in product screens)
    Get.lazyPut(() => BrandController(), fenix: true);
    Get.lazyPut(() => CreateBrandController());
    Get.lazyPut(() => EditBrandController());

    // 🖼️ Banners (depends on media controller)
    Get.lazyPut(() => BannerController(), fenix: true);
    Get.lazyPut(() => CreateBannerController());
    Get.lazyPut(() => EditBannerController());

    // 🛍️ Products (needs brand + category + media)
    Get.lazyPut(() => ProductController(), fenix: true);
    Get.lazyPut(() => ProductVariationsController());
    Get.lazyPut(() => ProductAttributesController());
    Get.lazyPut(() => ProductImagesController());
    Get.lazyPut(() => CreateProductController());
    Get.lazyPut(() => EditProductController());

    // 📦 Customers & Orders
    Get.lazyPut(() => CustomerController(), fenix: true);
    Get.lazyPut(() => CustomerDetailsController());
    Get.lazyPut(() => OrderController(), fenix: true);

    // 📊 Dashboard (entry screen)
    Get.lazyPut(() => DashboardController(), fenix: true);
  }
}

