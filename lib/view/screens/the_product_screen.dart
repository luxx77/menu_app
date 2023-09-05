import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/configs/scroll_controlling.dart';
import 'package:menu_app/configs/size_getters.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/data/notifier.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/screens/the_prod_body.dart';
import 'package:menu_app/view/widgets/appBars/the_product_leading.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';
import 'package:menu_app/view/widgets/error_widget.dart';
import 'package:menu_app/view/widgets/futureBuilders/childs_products_future_builder.dart';
import 'package:menu_app/view/widgets/futureBuilders/recomd_future_builder.dart';
import 'package:menu_app/view/widgets/headWidgets/the_product_head.dart';
import 'package:menu_app/view/widgets/place_holder.dart';

class TheProductScreen extends StatefulWidget {
  const TheProductScreen({super.key, required this.prod});
  final ProductModel prod;
  @override
  State<TheProductScreen> createState() => _TheProductScreenState();
}

class _TheProductScreenState extends State<TheProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    jumpp();
    mainData.valll.value = transpaentOverlay;

    controller.addListener(() {
      if (firstTime) {
        backGroundController.jumpTo(controller.offset);
      }
      if (oldOffset < controller.offset) {
      } else {
        secondControler.jumpTo(controller.offset);
      }

      if ((controller.offset - (378.h - statusBarHeight!)) >= 0) {
        if (SystemChrome.latestStyle!.statusBarColor == Colors.transparent) {
          mainData.valll.value = whiteOverlay;
        }
      } else {
        mainData.valll.value = transpaentOverlay;
      }
    });

    if (firstTime) {
      backGroundController.jumpTo(controller.offset);
      oldOffset = controller.offset;
    }

    maxJump(controller);

    firstTime = true;
  }

  void jumpp() async {
    await Future.delayed(const Duration(milliseconds: 8), () {
      if (!firstTime) {
        return;
      }
      if (controller.offset < 0) {
        backGroundController.jumpTo(controller.offset);
        secondControler.jumpTo(controller.offset);
      }
    });
    jumpp();
  }

  @override
  void dispose() {
    super.dispose();
    firstTime = false;
    controller.dispose();
  }

  final backGroundController = ScrollController();
  final mainData = getIt<MainData>(instanceName: 'mainData');
  bool firstTime = false;
  double oldOffset = 0;
  final controller = ScrollController();
  final secondControler = ScrollController();
  final langData = getIt<LanguageData>(instanceName: 'langData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomScrollView(
            controller: secondControler,
            slivers: [
              MyAppBar(
                imgUrl: widget.prod.imgUrl,
              ),
            ],
          ),
          CustomScrollView(
            controller: backGroundController,
            physics: mainPhysics,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 999.h,
                  margin: EdgeInsets.only(top: 370.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                ),
              )
            ],
          ),
          TheProdBody(controller: controller, id: widget.prod.id),
          const TheProductLeading()
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.imgUrl});
  final String imgUrl;
  static final data = getIt<MainData>(instanceName: 'mainData');
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: data.valll,
      builder: (context, color, child) {
        final provider = Provider.of<TryNotifier>(context);
        return SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          expandedHeight: 375.h,
          floating: false,
          pinned: false,
          snap: false,
          centerTitle: false,
          stretch: true,
          systemOverlayStyle: color,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            stretchModes: const [StretchMode.zoomBackground],
            background: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: '$mainUrl$imgUrl',
              placeholder: (context, url) => MyImagePlaceHolder(),
              errorWidget: (context, url, error) => MyErrorWidget(),
            ),
          ),
        );
      },
    );
  }
}
