import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/category_model.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class ParentCategoryWidget extends StatelessWidget {
  const ParentCategoryWidget({
    super.key,
    this.model,
    this.index,
  });
  final CategoryModel? model;

  final int? index;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  static final mainData = getIt<MainData>(instanceName: 'mainData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (model == null) {
          return;
        }
        apiData.currentParentId = model!.id;
        apiData.currentChildId.value = model!.firstChildId;
        mainData.bodyIndex.value = 2;
        mainData.inChildScreen = true;
      },
      child: Container(
        height: 180.h,
        width: 335.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: blur,
              color: shadowColor,
              offset: const Offset(1, 1),
              spreadRadius: radius,
            ),
            BoxShadow(
              blurRadius: blur,
              color: shadowColor,
              offset: const Offset(-1, -1),
              spreadRadius: radius,
            ),
          ],
          color: mainColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.only(
          top: index != 0 ? 0 : 8.h,
          bottom: 20.h,
          left: 20.w,
          right: 20.w,
        ),
        child: model == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: const MyImagePlaceHolder(),
              )
            : Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: SizedBox.expand(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const MyImagePlaceHolder(),
                        imageUrl: '$mainUrl${model!.imgUrl}',
                        errorWidget: (context, url, error) =>
                            const SizedBox.expand(
                          child: Center(
                            child: Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // height: 38.h,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: langData.language,
                      builder: (context, lang, child) {
                        return Text(
                          model!.titles[lang]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
