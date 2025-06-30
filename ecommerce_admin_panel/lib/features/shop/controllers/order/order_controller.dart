import 'package:ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:ecommerce_admin_panel/data/repositories/order/order_repository.dart';
import 'package:ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

/// 📦 OrderController
/// - Handles business logic for fetching, sorting, updating, and deleting orders.
/// - Extends [TBaseController] for DataTable integration.
class OrderController extends TBaseController<OrderModel> {
  /// Singleton instance
  static OrderController get instance => Get.find();

  /// 🔁 Observable flag for loading status while updating an order
  final RxBool statusLoader = false.obs;

  /// 📌 Selected order status (e.g., in dropdowns or UI filters)
  var orderStatus = OrderStatus.delivered.obs;

  /// 📥 Repository to communicate with Firestore
  final OrderRepository _repo = OrderRepository.instance;

  /// 🔍 Search logic for filtering orders by ID
  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  /// ❌ Deletes an order from Firestore by docId
  @override
  Future<void> deleteItem(OrderModel item) async {
    return await _repo.deleteUserOrders(item.docId);
  }

  /// 📤 Fetch all orders from Firestore
  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false; // default sort order
    return await _repo.fetchAllOrders();
  }

  // ------------------------ 📊 Sorting ------------------------

  /// 📊 Sort orders by total amount (as string for table compatibility)
  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
          (OrderModel o) => o.totalAmount.toString().toLowerCase(),
    );
  }

  /// 📅 Sort orders by order date
  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
          (OrderModel o) => o.orderDate.toString().toLowerCase(),
    );
  }

  // ------------------------ 🔄 Status Update ------------------------

  /// 🔁 Update order status in Firestore
  ///
  /// - Accepts the [OrderModel] and new [OrderStatus]
  /// - Updates both local state and Firestore
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;

      // Update local model
      order.status = newStatus;

      // Firestore update
      await _repo.updateOrderSpecificValue(order.docId, {
        'status': newStatus.toString(),
      });

      // Update UI state
      updateItemFromList(order);
      orderStatus.value = newStatus;

      // Show success snackbar
      TLoaders.successSnackBar(
        title: "Updated",
        message: "Order status updated successfully",
      );
    } catch (e) {
      TLoaders.warningSnackBar(
        title: "Oh Snap!",
        message: e.toString(),
      );
    } finally {
      statusLoader.value = false;
    }
  }
}
