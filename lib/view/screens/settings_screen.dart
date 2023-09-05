// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:v_1/constants/colors.dart';
// import 'package:v_1/constants/pathes.dart';
// import 'package:v_1/data/language_data.dart';
// import 'package:v_1/main.dart';
// import 'package:v_1/view/widgets/appBars/cart_app_bar.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//  static final langData = getIt<LanguageData>(instanceName: 'langData');
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const CartAppBar(forCart: false),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ValueListenableBuilder(
//                 valueListenable: langData.language,
//                 builder: (context, value, child) {
//                   return Text(
//                     'Language',
//                     style: GoogleFonts.urbanist(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 24.sp,
//                       color: navBarIconsColor,
//                     ),
//                   );
//                 },
//               ),
//               MyPopupButton(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MyPopupButton extends StatelessWidget {
//   const MyPopupButton({super.key});
//   static final langData = getIt<LanguageData>(instanceName: 'langData');
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       color: Colors.white,
//       shadowColor: Colors.black,
//       splashRadius: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(10.r),
//         ),
//       ),
//       itemBuilder: (context) {
//         return List.generate(
//           langData.languages.length,
//           (index) => PopupMenuItem(
//             onTap: () => langData.language.value = langData.languages[index],
//             height: 40.h,
//             child: Text(
//               langData.fullLanguages[index],
//               style: GoogleFonts.urbanist(
//                 fontSize: 15.sp,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         );
//       },
//       child: SizedBox(
//         height: 45.h,
//         // width: 90.w,
//         // color: Colors.red,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Türkmençe',
//               style: GoogleFonts.urbanist(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 20.sp,
//                 color: Color.fromRGBO(100, 100, 100, 1),
//               ),
//             ),
//             SizedBox(width: 23.w),
//             Icon(
//               Icons.keyboard_arrow_down_rounded,
//               size: 20.sp,
//               color: navBarIconsColor,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
