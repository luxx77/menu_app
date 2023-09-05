import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/category_model.dart';
import 'package:menu_app/view/widgets/error_widget.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class ChildCategoryWidget extends StatelessWidget {
  const ChildCategoryWidget({
    super.key,
    required this.index,
    this.model,
  });

  final int index;
  final CategoryModel? model;
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (model == null) {
          return;
        }
        apiData.currentChildId.value = model!.id;
      },
      child: ValueListenableBuilder(
        valueListenable: apiData.currentChildId,
        builder: (context, currentIndex, child) {
          final isSelected =
              model == null ? false : model!.id == apiData.currentChildId.value;
          return Container(
            height: 52.sp,
            width: 52.sp,
            margin: EdgeInsets.only(
              left: index != 0 ? 0 : 32.w,
              right: 35.w,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isSelected ? mainColor : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2.sp,
                          color: shadowColor,
                          spreadRadius: 0.1.sp,
                        )
                      ]
                    : null),
            child: model == null
                ? const MyImagePlaceHolder(
                    isShaped: true,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(999.r),
                    child: SizedBox.expand(
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const MyImagePlaceHolder(isShaped: true),
                        errorWidget: (context, url, error) =>
                            const MyErrorWidget(),
                        imageUrl: '$mainUrl${model!.imgUrl}',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
