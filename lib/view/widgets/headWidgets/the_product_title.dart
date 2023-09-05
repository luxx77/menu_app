import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';

class TheProductTitle extends StatelessWidget {
  const TheProductTitle({super.key, required this.model});
  final ProductModel model;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  String cookTime() {
    if (model.cookTime == null) {
      return '0 min';
    }
    return '${model.cookTime! ~/ 60 != 0 ? '${model.cookTime! ~/ 60} sag' : ''} ${model.cookTime! % 60} min';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: langData.language,
            builder: (context, lang, child) {
              return Text(model.titles[lang]!,
                  style: GoogleFonts.urbanist(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ));
            },
          ),
        ),
        SizedBox(
          width: 29.w,
        ),
        Column(
          children: [
            Row(
              children: [
                const Icon(Icons.timer),
                Text(
                  cookTime(),
                  style: GoogleFonts.urbanist(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h)
          ],
        )
      ],
    );
  }
}
