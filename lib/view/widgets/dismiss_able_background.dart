import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DismissAbleBackground extends StatelessWidget {
  const DismissAbleBackground({super.key, required this.leftSide});
  final bool leftSide;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: leftSide ? Alignment.centerLeft : Alignment.centerRight,
      padding: EdgeInsets.all(18.sp),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
        size: 24.sp,
      ),
    );
  }
}
