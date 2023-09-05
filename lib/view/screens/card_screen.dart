import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/main_data.dart';

import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/add_to_card_widgets.dart';
import 'package:menu_app/view/widgets/appBars/cart_app_bar.dart';
import 'package:menu_app/view/widgets/dismiss_able_background.dart';
import 'package:menu_app/view/widgets/imageWidgets/card_image.dart';
import 'package:menu_app/view/widgets/productWidgets/cart_widget.dart';
import 'package:menu_app/view/widgets/total_widget.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  static final data = getIt<MainData>(instanceName: 'mainData');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CartAppBar(forCart: true),
        ValueListenableBuilder(
            valueListenable: data.cartChanges,
            builder: (context, change, child) {
              // log('${data.cart.keys.length} keyLength');
              return Expanded(
                child: data.cart.isNotEmpty
                    ? ListView.builder(
                        controller: data.controllers[3],
                        physics: mainPhysics,
                        itemCount: data.cart.keys.length,
                        itemBuilder: (context, index) {
                          return CartWidget(
                            index: index,
                            key: ValueKey(data.cart.keys.toList()[index]),
                          );
                        },
                      )
                    : const Center(
                        child: Text('cart Empty'),
                      ),
              );
            }),
        const TotalWidget(),
      ],
    );
  }
}
