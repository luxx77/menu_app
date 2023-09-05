import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';

class MainAppBarTitle extends StatelessWidget {
  const MainAppBarTitle({super.key, required this.forWelcome});
  final bool forWelcome;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: const [
          TextSpan(
            text: 'М',
            style: TextStyle(
              color: mainColor,
            ),
          ),
          TextSpan(text: 'enu')
        ],
        style: TextStyle(
          fontWeight: forWelcome ? FontWeight.w800 : FontWeight.bold,
          fontSize: forWelcome ? 64.sp : 36.sp,
          color: navBarIconsColor,
        ),
      ),
    );
  }
}
