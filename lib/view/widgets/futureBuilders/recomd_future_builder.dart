// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:v_1/api/get_futures.dart';
// import 'package:v_1/data/api_data.dart';
// import 'package:v_1/main.dart';
// import 'package:v_1/view/widgets/builders/product_builder.dart';
// import 'package:v_1/view/widgets/error_widget.dart';

// class RecomendBuilder extends StatelessWidget {
//   const RecomendBuilder({
//     super.key,
//   });

//   static final apiData = getIt<ApiData>(instanceName: 'apiData');
//   static final futures = getIt<Futures>(instanceName: 'futures');
//   @override
//   Widget build(BuildContext context) {
//     final prodId = apiData.crrentTheProduct!;
//     log('${apiData.allProds.length} AllProd Length');
//     log('$prodId prodId ');
//     final theIndex = futures.findProdById(prodId);
//     final getted = apiData.allProds[theIndex].recs != null;
//     return FutureBuilder(
//       future: getted ? null : futures.getRecsByProdId(),
//       builder: (context, snap) {
//         if (snap.connectionState != ConnectionState.done && !getted) {
//           return const ProductBuilder();
//         }
//         if (snap.hasError || apiData.allProds[theIndex].recs == null) {
//           return const SliverToBoxAdapter(child: MyErrorWidget());
//         }
//         return ProductBuilder(
//           products: apiData.allProds[theIndex].recs,
//         );
//       },
//     );
//   }
// }
