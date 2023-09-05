import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final mainData = getIt<MainData>(instanceName: 'mainData');
  final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  void initState() {
    super.initState();
    log('SearchIniit');
    mainData.searchController.text = mainData.searchQuery.value;
    mainData.searchController.addListener(() {
      mainData.searchQuery.value = mainData.searchController.text;
    });
    mainData.searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.h),
      decoration: BoxDecoration(
        color: searchFieldColor,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(10.r)),
      ),
      height: 45.h,
      width: 310.w,
      child: ValueListenableBuilder(
          valueListenable: langData.language,
          builder: (context, lang, child) {
            return TextField(
              scrollPadding: EdgeInsets.zero,
              maxLines: 1,
              controller: mainData.searchController,
              focusNode: mainData.searchFocus,
              autocorrect: false,
              magnifierConfiguration: TextMagnifierConfiguration.disabled,
              style: GoogleFonts.urbanist(
                color: navBarIconsColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: ' ${langData.searchHint[lang]}',
                hintStyle: GoogleFonts.urbanist(
                  color: searchHintColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: EdgeInsets.only(
                  bottom: 6.5.h,
                  left: 8.w,
                ),
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            );
          }),
    );
  }
}
