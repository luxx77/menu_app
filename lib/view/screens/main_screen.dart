import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/configs/size_getters.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/screens/card_screen.dart';
import 'package:menu_app/view/screens/child_category_screen.dart';
import 'package:menu_app/view/screens/home_screen.dart';
import 'package:menu_app/view/screens/settings_screen.dart';
import 'package:menu_app/view/screens/the_product_screen.dart';
import 'package:menu_app/view/widgets/navBar/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final data = getIt<MainData>(instanceName: 'mainData');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.addMaxControllers();
    data.bodyIndex.addListener(() {
      if (data.bodyIndex.value == 2) {
        data.nowOnChild = true;
        return;
      }
      data.nowOnChild = false;
    });
  }

  List<Widget> screens = const [
    HomeScreen(),
    CardScreen(),
    ChildCategoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    getStatusBarHeight(context);
    return WillPopScope(
      onWillPop: () async {
        if (data.bodyIndex.value > 0) {
          data.bodyIndex.value = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: ValueListenableBuilder(
            valueListenable: data.bodyIndex,
            builder: (context, value, child) {
              return screens[value];
            }),
        bottomNavigationBar: const MyNavBar(),
      ),
    );
  }
}
