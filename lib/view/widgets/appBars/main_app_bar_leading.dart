import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';

class MainAppbarLeading extends StatelessWidget {
  const MainAppbarLeading({super.key});
  static final mainData = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mainData.bodyIndex,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (mainData.nowOnChild) {
              mainData.bodyIndex.value = 0;
              return;
            }
            Navigator.pop(context);
          },
          child: Container(
            width: 40.w,
            height: 27.h,
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 25.sp,
            ),
          ),
        );
      },
    );
  }
}
