import 'package:flutter/material.dart';

void getStatusBarHeight(BuildContext context) {
  statusBarHeight = MediaQuery.of(context).viewPadding.top;
}

double? statusBarHeight;

class SizeConfig {
  static double textSize = 0;
  static getSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    textSize = ((size.height + size.width) / 2) * 0.01;
  }
}
