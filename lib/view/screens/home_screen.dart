import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/appBars/main_app_bar.dart';
import 'package:menu_app/view/widgets/builders/parent_category_builder.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static final data = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: data.controllers[0],
      physics: mainPhysics,
      slivers: const [
        MainAppBar(),
        ParentCategoryBuilder(),
      ],
    );
  }
}
