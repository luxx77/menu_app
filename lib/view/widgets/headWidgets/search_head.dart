import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/sort_popup.dart';

class SearchHead extends StatelessWidget {
  const SearchHead({super.key});

  static final apiData = getIt<ApiData>(instanceName: 'apiData');

  static final langData = getIt<LanguageData>(instanceName: 'langData');

  static final data = getIt<MainData>(instanceName: 'mainData');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 2.5.h,
          spreadRadius: 1.h,
          offset: const Offset(1, 1),
          color: shadowColor,
        )
      ]),
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
              valueListenable: data.searchTitleListener,
              builder: (context, childId, chidl) {
                return Text(
                  '${apiData.searchList.length}-${langData.results[langData.language.value]}',
                  style: GoogleFonts.urbanist(
                    color: Colors.black,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
          const SortPopup(),
        ],
      ),
    );
  }
}
