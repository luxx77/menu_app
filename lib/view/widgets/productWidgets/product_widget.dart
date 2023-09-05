import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/screens/the_product_screen.dart';
import 'package:menu_app/view/widgets/add_to_card_widgets.dart';
import 'package:menu_app/view/widgets/imageWidgets/product_image_widget.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.index, this.model});
  final int index;

  final ProductModel? model;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  @override
  Widget build(BuildContext context) {
    log('prodBuild');
    return Container(
      color: Colors.white,
      width: (375 / 2).w,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          if (model == null) {
            return;
          }
          apiData.crrentTheProduct = model!.id;
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TheProductScreen(prod: model!),
              ));
        },
        child: Container(
          width: 173.w,
          height: model != null ? null : 220.h,
          margin: EdgeInsets.only(
            left: index % 2 == 0 ? 5.w : 0.w,
            right: index % 2 == 0 ? 0.w : 5.w,
            top: index > 2 ? 2.h : 4.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 2.sp,
                color: shadowColor,
                offset: const Offset(1, 1),
                spreadRadius: 0.5.sp,
              ),
              BoxShadow(
                blurRadius: 2.sp,
                color: shadowColor,
                offset: const Offset(-1, -1),
                spreadRadius: 0.5.sp,
              ),
            ],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: model == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: const MyImagePlaceHolder())
              : Column(
                  children: [
                    ProductImageWidget(url: model!.imgUrl),
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 9.h, horizontal: 9.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: langData.language,
                                builder: (context, lang, child) {
                                  return Text(
                                    model!.titles[lang]!,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 18.h,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                }),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${model!.price} tmt',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 15.h,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child:
                                      AddToCardHorizontal(false, id: model!.id),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
