import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/constants/pathes.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/screens/search_screen.dart';
import 'package:menu_app/view/widgets/appBars/main_app_bar_leading.dart';
import 'package:menu_app/view/widgets/appBars/main_app_bar_title.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      automaticallyImplyLeading: false,
      floating: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      toolbarHeight: 100.h,
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MainAppbarLeading(),
              const MainAppBarTitle(forWelcome: false),
              SizedBox(width: 40.w),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    settings: const RouteSettings(name: '/until'),
                    builder: (context) => const SearhScreen(),
                  ));
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 331.w,
              height: 45.h,
              padding: EdgeInsets.symmetric(horizontal: 13.w),
              decoration: BoxDecoration(
                color: searchFieldColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: langData.language,
                    builder: (context, value, child) {
                      return Text(
                        langData.searchHint[value]!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: searchHintColor,
                        ),
                      );
                    },
                  ),
                  ImageIcon(
                    const AssetImage(searchIconPath),
                    size: 20.sp,
                    color: navBarIconsColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
