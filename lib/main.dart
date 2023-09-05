import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:menu_app/configs/scroll_behavior.dart';
import 'package:menu_app/configs/size_getters.dart';
import 'package:menu_app/data/notifier.dart';
import 'package:menu_app/view/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

GetIt getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TryNotifier()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) =>
              ScrollConfiguration(behavior: MyBehavior(), child: child!),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
