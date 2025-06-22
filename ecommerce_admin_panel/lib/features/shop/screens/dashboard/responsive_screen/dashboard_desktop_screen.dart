import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_recent_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        DashboardRecentOrders()
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
