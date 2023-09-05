import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class TheProductHeadPlaceHolder extends StatelessWidget {
  const TheProductHeadPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
              top: 10.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 40.h,
                        width: 220.w,
                        child: MyImagePlaceHolder()),
                    SizedBox(height: 5.h),
                    SizedBox(
                        height: 40.h,
                        width: 220.w,
                        child: MyImagePlaceHolder()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
