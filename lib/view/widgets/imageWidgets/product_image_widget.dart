import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.url});
 final String url;
  @override
  Widget build(BuildContext context) {
   
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      child: SizedBox(
        width: double.infinity,
        height: 150.h,
        child: CachedNetworkImage(
          imageUrl:
              '$mainUrl$url',
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return const MyImagePlaceHolder();
          },
        ),
      ),
    );
  }
}
