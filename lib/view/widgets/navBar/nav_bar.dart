import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';

import '../../../constants/pathes.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  List<String> icons = const [
    homeIconPath,
    cardIconPath,
    // settingsIconPath,
  ];
  List<String> filledIcons = const [
    fHomeIconPath,
    fCardIconPath,
    // fSettingsIconPath,
  ];
  final data = getIt<MainData>(instanceName: 'mainData');

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 2.5.h,
            spreadRadius: 1.h,
            offset: const Offset(-1, -1),
            color: shadowColor)
      ]),
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 2; i++)
            GestureDetector(
              onTap: () {
                if (i == 0) {
                  if (data.nowOnChild) {
                    data.inChildScreen = false;
                    data.bodyIndex.value = 0;
                  }
                  if (data.inChildScreen) {
                    setState(() {
                      data.bodyIndex.value = 2;
                    });
                  } else {
                    setState(() {
                      data.inChildScreen = false;
                      data.bodyIndex.value = 0;
                    });
                  }
                  return;
                }
                setState(() {
                  data.bodyIndex.value = i;
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 41.sp,
                width: 43.sp,
                child: ValueListenableBuilder(
                    valueListenable: data.bodyIndex,
                    builder: (context, bodyIndex, child) {
                      return ImageIcon(
                        AssetImage(
                          bodyIndex == i
                              ? filledIcons[i]
                              : bodyIndex == 2 && i == 0
                                  ? filledIcons[0]
                                  : icons[i],
                        ),
                        size: 30.5.sp,
                        color: navBarIconsColor,
                      );
                    }),
              ),
            ),
        ],
      ),
    );
  }
}
