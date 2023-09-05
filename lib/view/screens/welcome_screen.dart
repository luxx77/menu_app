import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/configs/size_getters.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/appBars/main_app_bar_title.dart';
import 'package:menu_app/view/widgets/choose_lang_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static final langdata = getIt<LanguageData>(instanceName: 'langData');

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final langData = LanguageData();
  final data = MainData();
  final apiData = ApiData();
  final futures = Futures();
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton(langData, instanceName: 'langData');

    getIt.registerSingleton(apiData..init(), instanceName: 'apiData');
    getIt.registerSingleton(data..init(), instanceName: 'mainData');
    getIt.registerSingleton(futures..init(), instanceName: 'futures');
  }

  @override
  Widget build(BuildContext context) {
    getStatusBarHeight(context);
    List<int> list = [1, 2, 4, 5, 6, 7];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 17.h,
          top: 55.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MainAppBarTitle(forWelcome: true),
            Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: WelcomeScreen.langdata.language,
                  builder: (context, lang, child) => Text(
                    langData.choseLang[lang]!,
                    style: GoogleFonts.urbanist(
                      fontSize: 36.sp,
                      color: navBarIconsColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                const ChooseLangWidget(index: 0),
                SizedBox(height: 22.h),
                const ChooseLangWidget(index: 1),
                SizedBox(height: 22.h),
                const ChooseLangWidget(index: 2),
              ],
            ),
            SizedBox(),
            const SizedBox(
              width: double.infinity,
              child: MainAppBarTitle(
                forWelcome: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
