import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TheProdHeadError extends StatelessWidget {
  const TheProdHeadError({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 375.h),
        height: 300.h,
        width: double.infinity,
        child: const Center(
          child: Text('Error'),
        ),
      ),
    );
  }
}
