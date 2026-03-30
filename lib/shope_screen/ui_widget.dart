// import 'package:flutter/cupertino.dart';
//
// class _CommonTabUI extends StatelessWidget {
//   final String tabName;
//   const _CommonTabUI({required this.tabName});
//
//   @override
//   Widget build(BuildContext context) {
//     int itemCount = tabName == "Products" ? 8 : 5;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔹 CATEGORY CHIPS
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children:  [
//                 _CategoryChip("All"),
//                 SizedBox(width: 8),
//                 _CategoryChip("Fashion"),
//                 SizedBox(width: 8),
//                 _CategoryChip("Electronics"),
//                 SizedBox(width: 8),
//                 _CategoryChip("Deals"),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // 🔹 GRID
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: itemCount,
//             gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.60,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 16,
//             ),
//             itemBuilder: (context, index) {
//               return _CardItem(tabName: tabName);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }