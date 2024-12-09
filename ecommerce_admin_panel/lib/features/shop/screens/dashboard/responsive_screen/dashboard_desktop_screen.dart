import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
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
              const SizedBox(height: TSizes.spaceBtwSections,),

              // Graphs
              Row(
                children: [
                  Expanded(flex: 2,
                    child: Column(
                      children: [
                        // Bar graph
                        TRoundedContainer(),
                        SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        // Orders
                        TRoundedContainer()
                      ],
                    ),
                  ),
                  SizedBox(
                    width: TSizes.spaceBtwSections,
                  ),
                  // Pie chart
                  Expanded(child: TRoundedContainer())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyData extends DataTableSource {
//   final DashboardController controller = Get.put(DashboardController());
//
//   @override
//   DataRow? getRow(int index) {
//     final data = controller.filteredDataList[index];
//     return DataRow2(
//         onTap: () {},
//         selected: controller.selectedRows[index],
//         onSelectChanged: (value) =>
//             controller.selectedRows[index] = value ?? false,
//         cells: [
//           DataCell(Text(data['Column1'] ?? '')),
//           DataCell(Text(data['Column2'] ?? '')),
//           DataCell(Text(data['Column3'] ?? '')),
//           DataCell(Text(data['Column4'] ?? '')),
//         ]);
//   }
//
//   @override
//   bool get isRowCountApproximate => false;
//
//   @override
//   int get rowCount => controller.filteredDataList.length;
//
//   @override
//   int get selectedRowCount => 0;
// }
//
// class DashboardController extends GetxController {
//   var dataList = <Map<String, dynamic>>[].obs;
//   var filteredDataList = <Map<String, dynamic>>[].obs;
//   RxList<bool> selectedRows =
//       <bool>[].obs; // Observable list to store selected rows
//
//   RxInt sortColumnIndex =
//       1.obs; // Observable for tracking the index of the column for sorting
//   RxBool sortAscending = true
//       .obs; // Observable for tracking the sorting order (ascending or descending)
//   final searchTextController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchDummyData();
//   }
//
//   void searchQuery(String query) {
//     filteredDataList.assignAll(dataList
//         .where((item) => item['column1'].contains(query.toLowerCase())));
//   }
//
//   void sortById(int sortColumnIndex, bool ascending) {
//     sortAscending.value = ascending;
//     filteredDataList.sort((a, b) {
//       if (ascending) {
//         return filteredDataList[0]['column1']
//             .toString()
//             .toLowerCase()
//             .compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
//       } else {
//         return filteredDataList[0]['column1']
//             .toString()
//             .toLowerCase()
//             .compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
//       }
//     });
//     this.sortColumnIndex.value = sortColumnIndex;
//   }
//
//   void fetchDummyData() {
//     selectedRows.assignAll(
//         List.generate(36, (index) => false)); // Initialize selected rows
//     dataList.addAll(List.generate(
//         36,
//         (index) => {
//               'Column1': 'Data ${index + 1} -1',
//               'Column2': 'Data ${index + 1} -2',
//               'Column3': 'Data ${index + 1} -3',
//               'Column4': 'Data ${index + 1} -4',
//             }));
//     filteredDataList.addAll(List.generate(
//         36,
//         (index) => {
//               'Column1': 'Data ${index + 1} -1',
//               'Column2': 'Data ${index + 1} -2',
//               'Column3': 'Data ${index + 1} -3',
//               'Column4': 'Data ${index + 1} -4',
//             }));
//   }
// }
