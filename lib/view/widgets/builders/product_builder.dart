import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/enums/sort_enum.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/widgets/productWidgets/product_widget.dart';

class ProductBuilder extends StatelessWidget {
  ProductBuilder({super.key, this.products});
  List<ProductModel>? products;

  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final futures = getIt<Futures>(instanceName: 'futures');
  static final langData = getIt<LanguageData>(instanceName: 'langData');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: data.sortChanges,
      builder: (context, type, child) {
        if (products != null) {
          log('Prods REbuild andSort');
          products = List.from(data.justSort(products!, type));
        }
        return SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: langData.language.value != 'ru' ? 230.h : 233.h,
            mainAxisSpacing: 5.h,
          ),
          itemCount: products != null ? products!.length : null,
          itemBuilder: (context, index) => ProductWidget(
            index: index,
            model: products != null ? products![index] : null,
          ),
        );
      },
    );
  }
}






// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:menu_app/api/get_futures.dart';
// import 'package:menu_app/data/api_data.dart';
// import 'package:menu_app/main.dart';
// import 'package:menu_app/models/product_model.dart';
// import 'package:menu_app/view/widgets/productWidgets/product_widget.dart';

// class ProductBuilder extends StatelessWidget {
//   ProductBuilder({super.key, this.products});
//   List<ProductModel>? products;

//   static final apiData = getIt<ApiData>(instanceName: 'apiData');
//   static final futures = getIt<Futures>(instanceName: 'futures');

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: ValueListenableBuilder(
//         valueListenable: apiData.sortChanges,
//         builder: (context, value, child) {
//           if (products != null) {
//             products = List.from(apiData.abcSort(products!, true));
//           }
//           return Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: List.generate(
//               products != null ? products!.length : 999,
//               (index) => ProductWidget(
//                 index: index,
//                 model: products != null ? products![index] : null,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

