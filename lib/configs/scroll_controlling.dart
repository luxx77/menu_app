import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void maxJump(ScrollController controller) {
  bool added = false;
  controller.addListener(() {
    controller.position.addListener(() {
      final maxOffset = controller.position.maxScrollExtent;

      if (controller.offset < -200.h) {
        controller.jumpTo(-200.h);
      }
      if (controller.offset > maxOffset + 200.h) {
        controller.animateTo(maxOffset - 1.h,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  });
}

