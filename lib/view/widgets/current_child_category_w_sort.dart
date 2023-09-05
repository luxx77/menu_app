import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/constants/pathes.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/sort_popup.dart';

class CurretnCategoryWSort extends StatelessWidget {
  const CurretnCategoryWSort({
    super.key,
  });
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  int findChildById() {
    final list = apiData.childs[apiData.currentParentId!]!
        .toList()
        .map((e) => e.id)
        .toList();
    int index = 0;
    return list.indexOf(apiData.currentChildId.value!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
              valueListenable: apiData.currentChildId,
              builder: (context, childId, chidl) {
                return Text(
                  apiData.childs[apiData.currentParentId!] == null
                      ? langData.waiting[langData.language.value]!
                      : apiData
                          .childs[apiData.currentParentId!]![findChildById()]
                          .titles[langData.language.value]!,
                  style: GoogleFonts.urbanist(
                    color: Colors.black,
                    fontSize:  32.sp,
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
