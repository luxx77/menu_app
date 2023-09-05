import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/constants/colors.dart';

class MyImagePlaceHolder extends StatelessWidget {
  const MyImagePlaceHolder({super.key, this.isShaped});
  final bool? isShaped;
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 2100),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 198, 195, 195),
          shape: isShaped == true ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}
