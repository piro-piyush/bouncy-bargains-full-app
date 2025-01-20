import 'package:bouncy_bargain/features/personalization/models/user_model.dart';
import 'package:bouncy_bargain/features/shop/models/banner_model.dart';
import 'package:bouncy_bargain/features/shop/models/brand_category_model.dart';
import 'package:bouncy_bargain/features/shop/models/brand_model.dart';
import 'package:bouncy_bargain/features/shop/models/cart_model.dart';
import 'package:bouncy_bargain/features/shop/models/category_model.dart';
import 'package:bouncy_bargain/features/shop/models/order_model.dart';
import 'package:bouncy_bargain/features/shop/models/product_category_model.dart';
import 'package:bouncy_bargain/features/shop/models/product_model.dart';
import 'package:bouncy_bargain/features/shop/models/product_variation_model.dart';
import 'package:bouncy_bargain/routes/routes.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';

class XDummyData {
  // -- Banners
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: XImages.banner1, targetScreen: XRoutes.order, active: false),
    BannerModel(
        imageUrl: XImages.banner2, targetScreen: XRoutes.cart, active: true),
    BannerModel(
        imageUrl: XImages.banner3,
        targetScreen: XRoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: XImages.banner4, targetScreen: XRoutes.search, active: true),
    BannerModel(
        imageUrl: XImages.banner5,
        targetScreen: XRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: XImages.banner6,
        targetScreen: XRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: XImages.banner7,
        targetScreen: XRoutes.checkout,
        active: true),
    BannerModel(
        imageUrl: XImages.banner8, targetScreen: XRoutes.order, active: false),
  ];

  // -- User
  static final UserModel user = UserModel(
      id: "id",
      username: "username",
      email: "email",
      firstName: "firstName",
      lastName: "lastName",
      phoneNumber: "phoneNumber",
      profilePicture: "profilePicture");

  static final CartModel cart = CartModel();

  // -- Order
  static final List<OrderModel> orders = [];

  // -- List of all Categories
  static final List<CategoryModel> categories = [
    // Main categories
    CategoryModel(
        id: "1", name: "Sports", image: XImages.sportIcon, isFeatured: true),
    CategoryModel(
        id: "2",
        name: "Electronics",
        image: XImages.electronicsIcon,
        isFeatured: true),
    CategoryModel(
        id: "3", name: "Clothes", image: XImages.clothIcon, isFeatured: true),
    CategoryModel(
        id: "4", name: "Animals", image: XImages.animalIcon, isFeatured: true),
    CategoryModel(
        id: "5",
        name: "Furniture",
        image: XImages.furnitureIcon,
        isFeatured: true),
    CategoryModel(
        id: "6", name: "Shoes", image: XImages.cosmeticsIcon, isFeatured: true),
    CategoryModel(
        id: "7",
        name: "Cosmetic",
        image: XImages.cosmeticsIcon,
        isFeatured: true),
    CategoryModel(
        id: "8",
        name: "Jewelry",
        image: XImages.jeweleryIcon,
        isFeatured: true),

    // Subcategories for Sports
    CategoryModel(
        id: "9",
        name: "Sports Shoes",
        image: XImages.sportIcon,
        parentId: "1",
        isFeatured: false),
    CategoryModel(
        id: "10",
        name: "Track Suits",
        image: XImages.sportIcon,
        parentId: "1",
        isFeatured: false),
    CategoryModel(
        id: "11",
        name: "Sports Equipments",
        image: XImages.sportIcon,
        parentId: "1",
        isFeatured: false),

    // Subcategories for Furniture
    CategoryModel(
        id: "12",
        name: "Bedroom Furniture",
        parentId: "5",
        image: XImages.furnitureIcon,
        isFeatured: false),
    CategoryModel(
        id: "13",
        name: "Kitchen Furniture",
        parentId: "5",
        image: XImages.furnitureIcon,
        isFeatured: false),
    CategoryModel(
        id: "14",
        name: "Office Furniture",
        parentId: "5",
        image: XImages.furnitureIcon,
        isFeatured: false),

    // Subcategories for Electronics
    CategoryModel(
        id: "15",
        name: "Laptop",
        parentId: "2",
        image: XImages.electronicsIcon,
        isFeatured: false),
    CategoryModel(
        id: "16",
        name: "Mobile",
        parentId: "2",
        image: XImages.electronicsIcon,
        isFeatured: false),

    // Subcategories for Clothes
    CategoryModel(
        id: "17",
        name: "Shirts",
        parentId: "3",
        image: XImages.clothIcon,
        isFeatured: false),
  ];

// -- List of Brands
  static final List<BrandModel> brands = [
    BrandModel(
        id: "1",
        name: "Nike",
        image: XImages.nikeLogo,
        productsCount: 265,
        isFeatured: true),
    BrandModel(
        id: "2",
        name: "Adidas",
        image: XImages.adidasLogo,
        productsCount: 95,
        isFeatured: true),
    BrandModel(
        id: "3",
        name: "Jordan",
        image: XImages.jordanLogo,
        productsCount: 36,
        isFeatured: true),
    BrandModel(
        id: "4",
        name: "Puma",
        image: XImages.pumaLogo,
        productsCount: 65,
        isFeatured: true),
    BrandModel(
        id: "5",
        name: "Apple",
        image: XImages.appleLogo,
        productsCount: 16,
        isFeatured: true),
    BrandModel(
        id: "6",
        name: "Zara",
        image: XImages.zaraLogo,
        productsCount: 36,
        isFeatured: true),
    BrandModel(
        id: "7",
        name: "Samsung",
        image: XImages.electronicsIcon,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: "8",
        name: "Kenwood",
        image: XImages.kenwoodLogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: "9",
        name: "IKEA",
        image: XImages.ikeaLogo,
        productsCount: 36,
        isFeatured: false),
    BrandModel(
        id: "10",
        name: "Acer",
        image: XImages.acerLogo,
        productsCount: 36,
        isFeatured: false),
  ];

  // -- List of all Brand Categories
  static final List<BrandCategoryModel> brandCategories = [
    // Nike (Sports-related categories)
    BrandCategoryModel(brandId: "1", categoryId: "1"), // Sports
    BrandCategoryModel(brandId: "1", categoryId: "8"), // Sports Shoes
    BrandCategoryModel(brandId: "1", categoryId: "9"), // Track Suits
    BrandCategoryModel(brandId: "1", categoryId: "10"), // Sports Equipment

    // Adidas (Sports-related categories)
    BrandCategoryModel(brandId: "2", categoryId: "1"), // Sports
    BrandCategoryModel(brandId: "2", categoryId: "8"), // Sports Shoes
    BrandCategoryModel(brandId: "2", categoryId: "9"), // Track Suits
    BrandCategoryModel(brandId: "2", categoryId: "10"), // Sports Equipment

    // Jordan (Sports-related categories)
    BrandCategoryModel(brandId: "3", categoryId: "1"), // Sports
    BrandCategoryModel(brandId: "3", categoryId: "8"), // Sports Shoes
    BrandCategoryModel(brandId: "3", categoryId: "9"), // Track Suits
    BrandCategoryModel(brandId: "3", categoryId: "10"), // Sports Equipment

    // Puma (Sports-related categories)
    BrandCategoryModel(brandId: "4", categoryId: "1"), // Sports
    BrandCategoryModel(brandId: "4", categoryId: "8"), // Sports Shoes
    BrandCategoryModel(brandId: "4", categoryId: "9"), // Track Suits
    BrandCategoryModel(brandId: "4", categoryId: "10"), // Sports Equipment

    // Apple (Electronics categories)
    BrandCategoryModel(brandId: "5", categoryId: "15"), // Mobile
    BrandCategoryModel(brandId: "5", categoryId: "14"), // Laptop

    // Acer (Electronics categories)
    BrandCategoryModel(brandId: "10", categoryId: "15"), // Mobile
    BrandCategoryModel(brandId: "10", categoryId: "14"), // Laptop

    // Zara (Clothes categories)
    BrandCategoryModel(brandId: "6", categoryId: "3"), // Clothes
    BrandCategoryModel(brandId: "6", categoryId: "16"), // Shirts

    // Samsung (Electronics categories)
    BrandCategoryModel(brandId: "7", categoryId: "2"), // Electronics

    // Kenwood (Furniture-related categories)
    BrandCategoryModel(brandId: "8", categoryId: "5"), // Furniture
    BrandCategoryModel(brandId: "8", categoryId: "11"), // Bedroom Furniture
    BrandCategoryModel(brandId: "8", categoryId: "12"), // Kitchen Furniture
    BrandCategoryModel(brandId: "8", categoryId: "13"), // Office Furniture

    // IKEA (Furniture-related categories)
    BrandCategoryModel(brandId: "9", categoryId: "5"), // Furniture
    BrandCategoryModel(brandId: "9", categoryId: "11"), // Bedroom Furniture
    BrandCategoryModel(brandId: "9", categoryId: "12"), // Kitchen Furniture
    BrandCategoryModel(brandId: "9", categoryId: "13"), // Office Furniture
  ];

  // -- List of all Product Categories
  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: "productId", categoryId: "")
  ];

  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      title: 'Nike Air Jordan 1 Black/Red',
      stock: 50,
      price: 120.0,
      salePrice: 100,
      isFeatured: true,
      thumbnail: XImages.productImage7,
      description:
          'Classic Nike Air Jordan 1 sneakers with black and red design.',
      brand: BrandModel(
          id: "1",
          name: "Nike",
          image: XImages.nikeLogo,
          productsCount: 265,
          isFeatured: true),
      images: [XImages.productImage7, XImages.productImage1],
      sku: 'NAJ1-BR-01',
      categoryId: "6",
      // Shoes category
      productType: 'Sports Shoes',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 50,
            price: 120,
            salePrice: 100,
            image: XImages.productImage7,
            description:
                'Black and red edition of the Nike Air Jordan 1 sneakers.',
            attributeValues: {'size': '11', 'color': 'Black/Red'})
      ],
    ),
    ProductModel(
      id: '2',
      title: 'Adidas Football',
      stock: 200,
      price: 25.0,
      salePrice: 20,
      isFeatured: true,
      thumbnail: XImages.productImage28,
      description: 'High-quality football for professionals and enthusiasts.',
      brand: BrandModel(
          id: "2",
          name: "Adidas",
          image: XImages.adidasLogo,
          productsCount: 95,
          isFeatured: true),
      images: [XImages.productImage28, XImages.productImage1],
      sku: 'ADIDAS-FB-001',
      categoryId: "1",
      // Sports category
      productType: 'Sports Equipment',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
            id: '2',
            stock: 200,
            price: 25,
            salePrice: 20,
            image: XImages.productImage28,
            description: 'Official Adidas football.',
            attributeValues: {'size': '5', 'color': 'White'})
      ],
    ),
    ProductModel(
      id: '3',
      title: 'Samsung Galaxy S9',
      stock: 100,
      price: 700.0,
      salePrice: 650,
      isFeatured: false,
      thumbnail: XImages.productImage11,
      description:
          'Samsung Galaxy S9 with a sleek design and powerful features.',
      brand: BrandModel(
          id: "7",
          name: "Samsung",
          image: XImages.electronicsIcon,
          productsCount: 36,
          isFeatured: false),
      images: [XImages.productImage11, XImages.productImage12],
      sku: 'SGS9-001',
      categoryId: "16",
      // Mobile category
      productType: 'Mobile Phone',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
            id: '3',
            stock: 100,
            price: 700,
            salePrice: 650,
            image: XImages.productImage11,
            description:
                'Samsung Galaxy S9 with enhanced camera and performance.',
            attributeValues: {'color': 'Midnight Black', 'storage': '64GB'})
      ],
    ),
    ProductModel(
      id: '4',
      title: 'Apple iPhone 13 Pro',
      stock: 150,
      price: 999.0,
      salePrice: 950,
      isFeatured: true,
      thumbnail: XImages.productImage51,
      description: 'Apple iPhone 13 Pro with enhanced cameras and performance.',
      brand: BrandModel(
          id: "5",
          name: "Apple",
          image: XImages.appleLogo,
          productsCount: 16,
          isFeatured: true),
      images: [XImages.productImage51, XImages.productImage52],
      sku: 'IPH13PRO-001',
      categoryId: "16",
      // Mobile category
      productType: 'Smartphone',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
            id: '4',
            stock: 150,
            price: 999,
            salePrice: 950,
            image: XImages.productImage51,
            description:
                'Apple iPhone 13 Pro with enhanced camera and faster chip.',
            attributeValues: {'color': 'Graphite', 'storage': '128GB'})
      ],
    ),
    ProductModel(
      id: '5',
      title: 'Ikea Bedroom Wardrobe',
      stock: 30,
      price: 299.0,
      salePrice: 250,
      isFeatured: false,
      thumbnail: XImages.productImage35,
      description: 'Modern design wardrobe for bedroom storage.',
      brand: BrandModel(
          id: "9",
          name: "IKEA",
          image: XImages.ikeaLogo,
          productsCount: 36,
          isFeatured: false),
      images: [XImages.productImage35, XImages.productImage36],
      sku: 'IKEA-WARDROBE-001',
      categoryId: "12",
      // Bedroom Furniture category
      productType: 'Furniture',
      productAttributes: [],
      productVariations: [
        ProductVariationModel(
            id: '5',
            stock: 30,
            price: 299,
            salePrice: 250,
            image: XImages.productImage35,
            description: 'Ikea wardrobe with sliding doors and ample space.',
            attributeValues: {'color': 'White', 'size': 'Large'})
      ],
    ),
  ];
}
