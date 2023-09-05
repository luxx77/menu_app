import 'package:flutter/material.dart';

class MyRoute extends MaterialPageRoute {
  MyRoute({required WidgetBuilder builder, required super.settings})
      : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}