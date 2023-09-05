import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/constants/pathes.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';
import 'package:menu_app/view/widgets/builders/search_builder.dart';
import 'package:menu_app/view/widgets/headWidgets/search_head.dart';
import 'package:menu_app/view/widgets/search_field.dart';

class SearhScreen extends StatelessWidget {
  const SearhScreen({super.key});
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  static final futures = getIt<Futures>(instanceName: 'futures');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 73.h,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SearchField(),
              GestureDetector(
                onTap: () => data.searchFocus.requestFocus(),
                child: Container(
                  decoration: BoxDecoration(
                    color: searchFieldColor,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(10.r),
                    ),
                  ),
                  width: 31.w,
                  height: 45.h,
                  alignment: Alignment.centerLeft,
                  child: ImageIcon(
                    const AssetImage(searchIconPath),
                    size: 20.sp,
                    color: navBarIconsColor,
                  ),
                ),
              ),
            ],
          ),
          // centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: const [
            SearchHead(),
            // SizedBox(height: 5.h),
            SearchBuilder(),
          ],
        ));
  }
}



            // SliverPersistentHeader(
            //   floating: true,
            //   pinned: false,
            //   delegate: PersistentHeader(
            //     // color: Colors.blue,
            //     height: 58.h,
            //     margin: EdgeInsets.only(top: 11.h),
            //     widget: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           width: 160.w,
            //           margin: EdgeInsets.only(left: 22.w),
            //           height: 50.h,
            //           decoration: BoxDecoration(
            //               color: searchFieldColor,
            //               borderRadius: BorderRadius.circular(10.r)),
            //           alignment: Alignment.center,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'ParentCategory',
            //                 style: GoogleFonts.urbanist(
            //                   fontSize: 15.sp,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //               ),
            //               Icon(
            //                 Icons.keyboard_arrow_down_rounded,
            //                 size: 17.sp,
            //                 color: Colors.black,
            //               )
            //             ],
            //           ),
            //         ),
            //         Container(
            //           margin: EdgeInsets.only(right: 22.w),
            //           height: 50.h,
            //           width: 160.w,
            //           decoration: BoxDecoration(
            //             color: searchFieldColor,
            //             borderRadius: BorderRadius.circular(10.r),
            //           ),
            //           alignment: Alignment.center,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 'ParentCategory',
            //                 style: GoogleFonts.urbanist(
            //                   fontSize: 15.sp,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //               ),
            //               Icon(
            //                 Icons.keyboard_arrow_down_rounded,
            //                 size: 17.sp,
            //                 color: Colors.black,
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // )