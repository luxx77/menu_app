import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key, required this.forCart});
  final bool forCart;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  static final data = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      height: 73.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => data.returnToCart(),
            child: Container(
              // color: Colors.red,
              alignment: Alignment.center,
              height: 30.h,
              width: 30.h,
              child: Icon(
                Icons.restart_alt_rounded,
                size: 30.h,
                color: navBarIconsColor,
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: langData.language,
            builder: (context, lang, child) {
              return Text(
                forCart ? langData.cardTitle[lang]! : langData.settings[lang]!,
                style: GoogleFonts.urbanist(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w800,
                  color: navBarIconsColor,
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () => data.clearCart(context),
            child: Container(
              margin: EdgeInsets.only(left: 10.w),
              // color: Colors.red,
              alignment: Alignment.center,
              height: 30.h,
              width: 30.h,
              child: Icon(
                Icons.delete_forever,
                size: 30.h,
                color: navBarIconsColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
