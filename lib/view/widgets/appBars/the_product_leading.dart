import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/configs/size_getters.dart';
import 'package:menu_app/constants/colors.dart';

class TheProductLeading extends StatelessWidget {
  const TheProductLeading({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('LeadTapp');
        Navigator.popUntil(context, (route) {
          return route.settings.name == '/until';
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 12.w, vertical: statusBarHeight! + 10.h),
        decoration: BoxDecoration(
            color: mainColor, borderRadius: BorderRadius.circular(8.r)),
        height: 37.sp,
        width: 37.sp,
        child: Icon(
          Icons.arrow_back_rounded,
          size: 22.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
