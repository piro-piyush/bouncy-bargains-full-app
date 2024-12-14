import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
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
                      stats: 25,
                      title: 'Sales Total',
                      subTitle: '\$333.3',
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 15,
                      title: 'Average order Value',
                      subTitle: '\$24',
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 44,
                      title: 'Total orders',
                      subTitle: '32',
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                      stats: 2,
                      title: 'Visitors',
                      subTitle: '23,322',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Bar graph
                        TWeeklySalesGraph(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        // Orders
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recent Orders",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwSections,
                              ),
                              const DashboardOrderTable()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),

                  // Pie chart
                  Expanded(child: OrderStatusPieChart())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

FlTitlesData buildFlTitlesData() {
  return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                // Map index to the desired day of the week
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

                // Calculate the index and ensure it wraps around for the correct day
                final index = value.toInt() % days.length;

                // Get the day corresponding to the calculated index
                final day = days[index];
                return SideTitleWidget(
                  axisSide: AxisSide.bottom,
                  space: 0,
                  child: Text(day),
                );
              })),
      leftTitles: AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, interval: 200, reservedSize: 50)),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)));
}
