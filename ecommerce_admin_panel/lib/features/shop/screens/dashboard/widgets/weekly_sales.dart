import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weekly Sales",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Graph
          SizedBox(
              height: 400,
              child: BarChart(BarChartData(
                  titlesData: buildFlTitlesData(),
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
                      .map((entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                            BarChartRodData(
                                width: 30,
                                toY: entry.value,
                                color: TColors.primary,
                                borderRadius: BorderRadius.circular(TSizes.sm))
                          ]))
                      .toList(),
                  groupsSpace: TSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                          getTooltipColor: (_) => TColors.secondary),
                      touchCallback: TDeviceUtils.isDesktopScreen(context)
                          ? (barTouchEvent, barTouchResponse) {}
                          : null))))
        ],
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