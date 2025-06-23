import 'package:ecommerce_admin_panel/common/widgets/containers/circular_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: TSizes.spaceBtwItems,
            children: [
              TCircularIcon(
                icon: Iconsax.status,
                color: Colors.amber,
                backgroundColor: Colors.amber.withValues(alpha: 0.1),
                size: TSizes.md,
              ),
              Text(
                'Order Status',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Graph
          Obx(() {
            if (controller.orderStatusData.isEmpty) {
              return SizedBox(
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [TLoaderAnimation()],
                ),
              );
            }
            return SizedBox(
              height: 400,
              child: PieChart(PieChartData(
                  sections: controller.orderStatusData.entries.map((entry) {
                    final status = entry.key;
                    final count = entry.value;
                    return PieChartSectionData(
                        radius: 100,
                        title: count.toString(),
                        value: count.toDouble(),
                        color: THelperFunctions.getOrderStatusColor(status),
                        titleStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white));
                  }).toList(),
                  pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        // Handle touch events here if needed
                      },
                      enabled: true))),
            );
          }),

          // Show status and color meta
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Orders")),
                DataColumn(label: Text("Total")),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final totalAmount = controller.totalAmounts[status] ?? 0;
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      TCircularContainer(
                        width: 20,
                        height: 20,
                        backgroundColor:
                            THelperFunctions.getOrderStatusColor(status),
                      ),
                      Expanded(
                        child:
                            Text(' ${controller.getDisplayStatusName(status)}'),
                      ),
                    ],
                  )),
                  DataCell(Text(count.toString())),
                  DataCell(Text('\$${totalAmount.toStringAsFixed(2)}')),
                ]);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
