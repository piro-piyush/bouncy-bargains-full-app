import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/responsive_screen/dashboard_desktop_screen.dart';
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
                      .map((entry) => BarChartGroupData(x: entry.key, barRods: [
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
