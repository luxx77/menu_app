import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/colors.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  final Color? color;
  final bool? haveShadow;
  final EdgeInsets? margin;

  PersistentHeader({
    this.haveShadow,
    required this.widget,
    required this.height,
    this.margin,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          boxShadow: haveShadow == true
              ? [
                  BoxShadow(
                    blurRadius: blur,
                    color: shadowColor,
                    spreadRadius: radius,
                    offset: Offset(1, 1),
                  )
                ]
              : null),
      width: double.infinity,
      height: height,
      child: widget,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
