import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key});

  static final data = getIt<MainData>(instanceName: 'mainData');
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: data.cartChanges,
        builder: (context, value, child) {
          return Container(
            height: 83.h,
            width: double.infinity,
            color: mainColor,
            alignment: Alignment.center,
            child: ValueListenableBuilder(
              valueListenable: langData.language,
              builder: (context, lang, child) {
                return Text(
                  '${langData.total[lang]!}: ${data.getTotal()}',
                  style: GoogleFonts.urbanist(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              },
            ),
          );
        });
  }
}
