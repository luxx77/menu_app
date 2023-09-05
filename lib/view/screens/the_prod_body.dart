import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/notifier.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';
import 'package:menu_app/view/widgets/errors/the_prod_head_error.dart';
import 'package:menu_app/view/widgets/futureBuilders/recomd_future_builder.dart';
import 'package:menu_app/view/widgets/headWidgets/the_product_head.dart';

class TheProdBody extends StatefulWidget {
  const TheProdBody({super.key, required this.controller, required this.id});
  final ScrollController controller;
  final int id;
  @override
  State<TheProdBody> createState() => _TheProdBodyState();
}

class _TheProdBodyState extends State<TheProdBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clear();
  }

  bool allGot = false;
  bool headGot = false;
  bool recsGetted = false;
  final futures = getIt<Futures>(instanceName: 'futures');
  final apiData = getIt<ApiData>(instanceName: 'apiData');
  void clear() {
    final theIndex = futures.findProdById(widget.id);
    if (theIndex == 6666) {
      return;
    }
    final theProd = apiData.allProds[theIndex];
    if (theProd.descirption != null &&
        theProd.recs != null &&
        theProd.cookTime != null) {
      log('allGot True');
      allGot = true;
    }
  }

  bool haveHeadError = false;
  bool haveRecsError = false;
  @override
  Widget build(BuildContext context) {
    clear();
    log('reBuilding');
    return FutureBuilder(
        future: !allGot
            ? !headGot
                ? futures.getTheProduct().then((value) {
                    if (value == 6666) {
                      log('HEADDDD ERRRORORO');
                      haveHeadError = true;
                    } else {
                      haveHeadError = false;
                    }
                    headGot = true;
                    setState(() {});
                  })
                : futures.getRecsByProdId().then((value) {
                    if (value == 6666) {
                      log('HEADDDD ERRRORORO');
                      haveRecsError = true;
                    } else {
                      haveRecsError = false;
                    }
                    recsGetted = true;
                    allGot = true;
                  })
            : null,
        builder: (context, snap) {
          ProductModel? theProd = allGot || headGot
              ? apiData.allProds[futures.findProdById(widget.id)]
              : null;
          if (haveHeadError) {
            return CustomScrollView(
                controller: widget.controller,
                physics: mainPhysics,
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        clear();
                        setState(() {});
                      },
                      child: Text(
                        'Try Again pls',
                      ),
                    )),
                  ),
                ]);
          }
          if (allGot) {
            log('${theProd!.titles['en']} ${theProd.cookTime}');
            return CustomScrollView(
              controller: widget.controller,
              physics: mainPhysics,
              slivers: [
                TheProductHead(
                  theProd: theProd,
                ),
                ProductBuilder(
                  products: theProd.cookTime != null ? theProd.recs : [],
                )
              ],
            );
          }
          log('SEçonf TIme Head Errror $haveHeadError');

          return CustomScrollView(
            controller: widget.controller,
            physics: mainPhysics,
            slivers: [
              TheProductHead(
                theProd: headGot ? theProd : null,
              ),
              ProductBuilder(
                products: recsGetted ? theProd!.recs : null,
              ),
            ],
          );
        });
  }
}
