import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const mainColor = Color.fromRGBO(248, 175, 35, 1);
const searchFieldColor = Color.fromRGBO(234, 234, 234, 1);
const cardColor = Color.fromRGBO(246, 246, 246, 1);
const searchHintColor = Color.fromRGBO(135, 135, 135, 1);
const navBarIconsColor = Color.fromRGBO(40, 48, 63, 1);
const descriptionColor = Color.fromRGBO(40, 48, 63, 0.7);
// parent category
final radius = 0.1.sp;
final blur = 3.sp;
const shadowColor = Color.fromARGB(34, 0, 0, 0);
// const darkModeBackground = Color.fromRGBO(40, 48, 63, 1);

const transpaentOverlay = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
);
const whiteOverlay = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
);

const mainPhysics =
    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

const cartDuration = Duration(milliseconds: 100);
