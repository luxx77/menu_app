import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/screens/the_product_screen.dart';
import 'package:menu_app/view/widgets/add_to_card_widgets.dart';
import 'package:menu_app/view/widgets/dismiss_able_background.dart';
import 'package:menu_app/view/widgets/imageWidgets/card_image.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({required super.key, required this.index});
  final int index;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  bool dismissing = false;
  final data = getIt<MainData>(instanceName: 'mainData');
  final langData = getIt<LanguageData>(instanceName: 'langData');
  final apiData = getIt<ApiData>(instanceName: 'apiData');
  final futures = getIt<Futures>(instanceName: 'futures');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textSize = ((size.height + size.width) / 2) * 0.01;
    final theProd = apiData
        .allProds[futures.findProdById(data.cart.keys.toList()[widget.index])];
    return Dismissible(
      background: const DismissAbleBackground(leftSide: true),
      secondaryBackground: const DismissAbleBackground(leftSide: false),
      key: widget.key!,
      onDismissed: (direction) {
        data.trashBox.add(theProd.id);
        data.cart.remove(theProd.id);
        data.notik();
        setState(() {
          dismissing = false;
        });
      },
      onResize: () {},
      onUpdate: (details) {
        if (details.progress == 0 || details.progress == 1) {
          setState(() {
            dismissing = false;
          });
          return;
        }
        if (dismissing) {
          return;
        }
        setState(() {
          log('message');
          dismissing = true;
        });
      },
      child: GestureDetector(
        onTap: () {
          apiData.crrentTheProduct = theProd.id;
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TheProductScreen(prod: theProd),
              ));
        },
        child: AnimatedContainer(
          duration: cartDuration,
          height: langData.language.value != 'ru' ? 100.h : 103.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: dismissing
                ? mainColor
                : const Color.fromARGB(255, 241, 240, 240),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 7.5.h,
          ),
          child: Row(
            children: [
              CardImage(imgUrl: theProd.imgUrl),
              Container(
                width: 145.w,
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      theProd.titles[langData.language.value]!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                        fontSize: textSize * 2.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${theProd.price} tmt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                        fontSize: textSize * 2.6,
                        fontWeight: FontWeight.w700,
                        color: dismissing ? Colors.white : mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 25.w,
                ),
                child: AddToCardVertical(
                  id: theProd.id,
                  color: dismissing ? Colors.white : mainColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
