import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_recent_orders.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
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
              TDashboardCard(
                stats: 25,
                title: 'Sales Total',
                subTitle: '\$333.3',
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 15,
                title: 'Average order Value',
                subTitle: '\$24',
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 44,
                title: 'Total orders',
                subTitle: '32',
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TDashboardCard(
                stats: 2,
                title: 'Visitors',
                subTitle: '23,322',
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
          ),
        ),
      ),
    );
  }
}
