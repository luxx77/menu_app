import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/appBars/main_app_bar.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';
import 'package:menu_app/view/widgets/futureBuilders/childs_products_future_builder.dart';
import 'package:menu_app/view/widgets/headWidgets/child_meals_head.dart';
import 'dart:developer';

class ChildCategoryScreen extends StatelessWidget {
  const ChildCategoryScreen({super.key});
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: data.controllers[2],
      physics: mainPhysics,
      slivers: [
        const MainAppBar(),
        const ChildCategoryHeadWidget(),
        SliverToBoxAdapter(
          child: SizedBox(height: 5.h),
        ),
        ValueListenableBuilder(
            valueListenable: apiData.currentChildId,
            builder: (context, id, child) {
              
              return  ChildsProductBuilder();
            }),
        SliverToBoxAdapter(
          child: SizedBox(height: 5.h),
        ),
      ],
    );
  }
}
