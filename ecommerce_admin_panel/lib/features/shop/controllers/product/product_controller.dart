import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:get/get.dart';

class ProductController extends TBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _repo = ProductRepository.instance;

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    return item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.brand!.name.toLowerCase().contains(query.toLowerCase()) ||
        item.price.toString().contains(query) ||
        item.stock.toString().contains(query);
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    await _repo.deleteProduct(productId: item.id);
  }

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _repo.getAllProducts();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.title.toLowerCase());
  }

  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.price);
  }

  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(
        sortColumnIndex, ascending, (ProductModel product) => product.stock);
  }

  void sortBySoldQuantity(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (ProductModel product) => product.soldQuantity);
  }

  String getProductPrice(ProductModel product) {
    // If no variations exist, return the simple price or sale price
    if (product.productType == ProductType.single.toString() ||
        product.productVariations!.isEmpty) {
      return (product.salePrice > 0.0 ? product.salePrice : product.price)
          .toString();
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // if smallest and largest prices are the same, return the simple price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        // Otherwise return the range of prices
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// -- Calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// -- Calculate  Product stock
  String getProductStockTotal(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.stock.toString()
        : product.productVariations!
            .fold<int>(
                0, (previousValue, element) => previousValue + element.stock)
            .toString();
  }

  /// -- Calculate  Product stock
  String getProductSoldQuantity(ProductModel product) {
    return product.productType == ProductType.single.toString()
        ? product.soldQuantity.toString()
        : product.productVariations!
        .fold<int>(
        0, (previousValue, element) => previousValue + element.stock)
        .toString();
  }

  /// -- Check product stock
  String getProductStockStatus(ProductModel product) {
    return product.stock > 0 ? "In Stock" : "Out of Stock";
  }

  void selectVariationImage(ProductVariationModel variation){}
}
