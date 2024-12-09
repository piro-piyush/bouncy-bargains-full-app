import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

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
                ],
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Row(
                children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
