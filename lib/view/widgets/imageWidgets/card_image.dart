import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/error_widget.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.imgUrl});
  final String imgUrl;
  static final langData = getIt<LanguageData>(instanceName: 'langData');
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(25.r),
      ),
      child: Container(
        color: Colors.white,
        height: langData.language.value != 'ru' ? 100.h : 103.h,
        width: 100.w,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '$mainUrl$imgUrl',
          placeholder: (context, url) => MyImagePlaceHolder(),
          errorWidget: (context, url, error) => MyErrorWidget(),
        ),
      ),
    );
  }
}
