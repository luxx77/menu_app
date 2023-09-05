import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';

class AddToCardHorizontal extends StatelessWidget {
  const AddToCardHorizontal(this.big, {super.key, required this.id});
  final int id;
  final bool big;
  static final data = getIt<MainData>(instanceName: 'mainData');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: data.cartChanges,
        builder: (context, value, child) {
          final theCount = data.findCount(id);
          if (theCount == 0) {
            return JustAddToCart(big, id: id);
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddOrRemoveCart(id: id, toAdd: false, big: big),
              Text(
                '$theCount',
                style: GoogleFonts.urbanist(
                  fontSize: big ? 25.sp : 15.sp,
                  fontWeight: FontWeight.w600,
                  // color: mainColor,
                ),
              ),
              AddOrRemoveCart(id: id, toAdd: true, big: big),
            ],
          );
        });
  }
}

class AddToCardVertical extends StatelessWidget {
  const AddToCardVertical({super.key, required this.color, required this.id});
  final Color color;
  final int id;
  static final data = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AddOrRemoveCart(id: id, toAdd: false, big: false, color: color),
        Text(
          '${data.findCount(id)}',
          style: GoogleFonts.urbanist(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        AddOrRemoveCart(id: id, toAdd: true, big: false, color: color),
      ],
    );
  }
}

class JustAddToCart extends StatelessWidget {
  const JustAddToCart(
    this.big, {
    super.key,
    required this.id,
  });
  final int id;
  final bool big;
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => data.addToCart(id),
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(big ? 8.r : 3.r),
        ),
        height: big ? 50.h : 25.h,
        width: 150.w,
        alignment: Alignment.center,
        child: Text(
          langData.addToCart[langData.language.value]!,
          style: GoogleFonts.urbanist(
            fontSize: big ? 21.sp : 13.sp,
            fontWeight: big ? FontWeight.w900 : FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class AddOrRemoveCart extends StatelessWidget {
  const AddOrRemoveCart({
    super.key,
    this.color,
    required this.id,
    required this.toAdd,
    required this.big,
  });
  final Color? color;
  final int id;
  final bool toAdd;
  final bool big;
  static final data = getIt<MainData>(instanceName: 'mainData');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (toAdd) {
          data.addToCart(id);
          return;
        }
        data.removeFromCart(id, color != null);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: cartDuration.inMilliseconds + 50),
        margin: big ? EdgeInsets.symmetric(vertical: 7.5.h) : null,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? mainColor,
          borderRadius: BorderRadius.circular(3.r),
        ),
        height: big ? 35.h : 25.h,
        width: big ? 35.h : 25.h,
        child: Icon(
          toAdd ? Icons.add : Icons.remove_rounded,
          color: navBarIconsColor,
          size: 17.sp,
        ),
      ),
    );
  }
}
