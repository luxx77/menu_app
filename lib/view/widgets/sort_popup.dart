import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/constants/pathes.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/enums/sort_enum.dart';
import 'package:menu_app/main.dart';

class SortPopup extends StatelessWidget {
  const SortPopup({super.key});
  static const Map<SortType, String> sorts = {
    SortType.news: 'new Added',
    SortType.abcSort: 'A to Z Sort',
    SortType.abcMirror: 'Z to A Sort',
    SortType.priceSort: 'Price Sort',
    SortType.priceMirror: 'Price Mirror',
  };
  static final data = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      shadowColor: Colors.black,
      splashRadius: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      itemBuilder: (context) {
        return List.generate(
          sorts.length,
          (index) => PopupMenuItem(
            onTap: () {
              data.sortChanges.value = sorts.keys.toList()[index];
            },
            height: 40.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                  color: data.sortChanges.value != sorts.keys.toList()[index]
                      ? Colors.transparent
                      : mainColor,
                  borderRadius: BorderRadius.circular(2.r)),
              child: Text(
                sorts.values.toList()[index],
                style: GoogleFonts.urbanist(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
      child: const ImageIcon(
        AssetImage(sortIcon),
      ),
    );
  }
}
