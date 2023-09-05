import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/configs/my_route.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/screens/main_screen.dart';
import 'package:menu_app/view/screens/the_product_screen.dart';

class ChooseLangWidget extends StatelessWidget {
  const ChooseLangWidget({super.key, required this.index});
  final int index;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: langData.language,
        builder: (context, lang, child) {
          final isSelected = lang == langData.cardTitle.keys.toList()[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const TheProductScreen(),
              //     ));
              // return;
              Navigator.push(
                  context,
                  MyRoute(
                    settings: const RouteSettings(name: '/until'),
                    builder: (context) => const MainScreen(),
                  ));
              langData.language.value = langData.total.keys.toList()[index];
            },
            child: Container(
              width: 247.w,
              height: 55.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? navBarIconsColor : null,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: navBarIconsColor,
                  width: 2.sp,
                ),
              ),
              child: Text(
                langData.fullLanguages[index],
                style: GoogleFonts.urbanist(
                  color: isSelected ? Colors.white : navBarIconsColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        });
  }
}
