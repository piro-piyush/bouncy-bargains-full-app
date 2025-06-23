import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({
    super.key,
  });

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
                icon: Iconsax.graph,
                color: Colors.brown,
                backgroundColor: Colors.brown.withValues(alpha: 0.1),
                size: TSizes.md,
              ),
              Text(
                "Weekly Sales",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Graph
          Obx(() {
            if (controller.weeklySales.isEmpty) {
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
                child: BarChart(BarChartData(
                    titlesData: buildFlTitlesData(controller.weeklySales),
                    borderData: FlBorderData(
                        show: true,
                        border: Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                        )),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      horizontalInterval: 200,
                    ),
                    barGroups: controller.weeklySales
                        .asMap()
                        .entries
                        .map((entry) =>
                            BarChartGroupData(x: entry.key, barRods: [
                              BarChartRodData(
                                  width: 30,
                                  toY: entry.value,
                                  color: TColors.primary,
                                  borderRadius:
                                      BorderRadius.circular(TSizes.sm))
                            ]))
                        .toList(),
                    groupsSpace: TSizes.spaceBtwItems,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) => TColors.secondary),
                        touchCallback: TDeviceUtils.isDesktopScreen(context)
                            ? (barTouchEvent, barTouchResponse) {}
                            : null))));
          })
        ],
      ),
    );
  }
}

FlTitlesData buildFlTitlesData(List<double> weeklySales) {
  // Calculate step height for the left padding
  double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
  double stepHeight = (maxOrder / 10).ceilToDouble();
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
          sideTitles: SideTitles(
              showTitles: true, interval: stepHeight <= 0 ? 500: stepHeight, reservedSize: 50)),
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)));
}
