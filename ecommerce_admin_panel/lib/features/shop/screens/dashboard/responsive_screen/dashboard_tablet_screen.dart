import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_recent_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Cards
                Row(
                  children: [
                    Expanded(
                      child: TDashboardCard(
                        headingIcon: Iconsax.note,
                        headingIconColor: Colors.blue,
                        headingBgColor: Colors.blue.withValues(alpha: 0.1),
                        growthWidget: controller.getSalesGrowthWidget(context),
                        title: 'Sales Total',
                        context: context,
                        subTitle: '\$${controller.getTotalSales()}',
                        lastMonth: controller.getLastMonthFormatted(),
                      ),
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: TDashboardCard(
                        headingIcon: Iconsax.external_drive,
                        headingIconColor: Colors.green,
                        headingBgColor: Colors.green.withValues(alpha: 0.1),
                        context: context,
                        title: 'Average order Value',
                        subTitle: '\$${controller.getAverageOrderValue()}',
                        lastMonth: controller.getLastMonthFormatted(),
                        growthWidget: controller.getAvgOrderValueGrowthWidget(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  children: [
                    Expanded(
                      child:TDashboardCard(
                        headingIcon: Iconsax.box,
                        headingIconColor: Colors.deepPurple,
                        headingBgColor:
                        Colors.deepPurple.withValues(alpha: 0.1),
                        context: context,
                        growthWidget: controller.getOrderCountGrowthWidget(context),
                        title: 'Total orders',
                        subTitle: '\$${controller.getTotalOrders()}',
                        lastMonth: controller.getLastMonthFormatted(),

                      ),
                    ),
                    SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: TDashboardCard(
                        headingIcon: Iconsax.user,
                        headingIconColor: Colors.deepOrange,
                        headingBgColor:
                        Colors.deepOrange.withValues(alpha: 0.1),
                        context: context,
                        growthWidget: controller.getCustomerGrowthWidget(context),
                        title: 'Visitors',
                        subTitle: '\$${controller.getTotalCustomers()}',
                        lastMonth: controller.getLastMonthFormatted(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Bar Graph
                const TWeeklySalesGraph(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Orders
                DashboardRecentOrders(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                // Pie Chart
                OrderStatusPieChart()
              ],
            );
          }),
        ),
      ),
    );
  }
}
