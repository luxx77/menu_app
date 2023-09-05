import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/widgets/add_to_card_widgets.dart';
import 'package:menu_app/view/widgets/placeHolders/the_product_place_holder.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

import 'the_product_title.dart';

class TheProductHead extends StatelessWidget {
  const TheProductHead({super.key, this.theProd});
  final ProductModel? theProd;
  static final _langData = getIt<LanguageData>(instanceName: 'langData');
  static final _futures = getIt<Futures>(instanceName: 'futures');
  static final _apiData = getIt<ApiData>(instanceName: 'apiData');
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 370.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r),
          ),
        ),
        child: theProd != null
            ? theProd!.cookTime != null
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: 10.h,
                      top: 20.h,
                      left: 10.w,
                      right: 10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TheProductTitle(
                          model: theProd!,
                        ),
                        SizedBox(height: 25.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${theProd!.price} tmt',
                                style: GoogleFonts.urbanist(
                                  color: mainColor,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w900,
                                )),
                            SizedBox(
                                width: 150.w,
                                child:
                                    AddToCardHorizontal(true, id: theProd!.id)),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        ValueListenableBuilder(
                          valueListenable: _langData.language,
                          builder: (context, lang, child) {
                            return Text(
                              theProd!.descirption![lang]!,
                              style: GoogleFonts.urbanist(
                                color: descriptionColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20.h),
                        ValueListenableBuilder(
                          valueListenable: _langData.language,
                          builder: (context, lang, child) {
                            return Text(
                              _langData.recs[lang]!,
                              style: GoogleFonts.urbanist(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: Text('SomeTHingsWent Wrong'),
                  )
            : const Center(
                child: Text(
                  ' PLs Wait',
                ),
              ),
      ),
    );
  }
}
