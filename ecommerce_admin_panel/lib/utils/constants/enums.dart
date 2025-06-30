/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

import 'package:ecommerce_admin_panel/utils/constants/text_strings.dart';

/// Switch of Custom Brand-Text-Size Widget
enum AppRole {admin,user }

enum TransactionType { buy, sell }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum TextSizes { small, medium, large }

enum ImageType { asset, network, memory, file }

enum MediaCategory { folders, banners, brands, categories, products, users , appLogos}

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods { paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm }


extension MediaCategoryExtension on MediaCategory {
  String get label {
    switch (this) {
      case MediaCategory.folders:
        return "Folders";
      case MediaCategory.banners:
        return "Banners";
      case MediaCategory.brands:
        return "Brands";
      case MediaCategory.categories:
        return "Categories";
      case MediaCategory.products:
        return "Products";
      case MediaCategory.users:
        return "Users";
      case MediaCategory.appLogos:
        return "App Logos";
    }
  }

  String get path {
    switch (this) {
      case MediaCategory.banners:
        return TTexts.bannersStoragePath;
      case MediaCategory.brands:
        return TTexts.brandsStoragePath;
      case MediaCategory.categories:
        return TTexts.categoriesStoragePath;
      case MediaCategory.products:
        return TTexts.productsStoragePath;
      case MediaCategory.users:
        return TTexts.usersStoragePath;
      case MediaCategory.appLogos:
        return TTexts.appLogosImagePath;
      default:
        return TTexts.otherImagePath;
    }
  }
}
