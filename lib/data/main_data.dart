import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:menu_app/configs/scroll_controlling.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/enums/sort_enum.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';

class MainData with ChangeNotifier {
  ApiData? apiData;
  LanguageData? langData;
  final searchController = TextEditingController();
  final searchListener = ValueNotifier<bool>(false);
  final searchTitleListener = ValueNotifier<bool>(false);
  final sortChanges = ValueNotifier<SortType>(SortType.news);
   

  void init() {
    apiData = getIt<ApiData>(instanceName: 'apiData');
    langData = getIt<LanguageData>(instanceName: 'langData');
  }

  final bodyIndex = ValueNotifier<int>(0);
  final valll = ValueNotifier<SystemUiOverlayStyle>(transpaentOverlay);
  final searchQuery = ValueNotifier<String>('');

  final searchFocus = FocusNode();
  TabController? tabController;
  bool controllerAdded = false;
  bool cartListeninig = false;
  double? statusBarHeight;
  final cartChanges = ValueNotifier(false);
  final controllers = List.generate(4, (index) => ScrollController());
  void addMaxControllers() {
    for (int i = 0; i < controllers.length; i++) {
      maxJump(controllers[i]);
    }
  }

  bool nowOnChild = false;
  bool focused = false;
  bool inChildScreen = false;
  Map<int, int> cart = {};
  List<int> trashBox = [];

  void addToCart(int id) {
    final theProd = cart[id];
    if (theProd == 99) {
      log('RETORNNNNNn');
      return;
    }
    if (theProd != null) {
      cart[id] = cart[id]! + 1;
      notik();
      return;
    }
    cart[id] = 1;

    notik();
  }

  void removeFromCart(int id, bool trashIt) {
    final theProd = cart[id];
    if (theProd == 1) {
      if (trashIt) {
        trashBox.add(id);
      }
      cart.remove(id);
      notik();
      return;
    }
    cart[id] = theProd! - 1;
    notik();
  }

  void returnToCart() {
    if (trashBox.isEmpty) {
      return;
    }
    addToCart(trashBox.last);
    trashBox.removeAt(trashBox.length-1);
    notik();
  }

  void notik() {
    cartChanges.value = !cartChanges.value;
  }

  int findCount(int id) {
    final theProd = cart[id];
    if (theProd != null) {
      return theProd;
    }
    return 0;
  }

  int findProdById(int id) {
    final list = apiData!.allProds.map((e) => e.id).toList();
    return list.indexOf(id);
  }

  String getTotal() {
    double total = 0;
    for (var i in cart.keys) {
      final prod = apiData!.allProds[findProdById(i)].price;
      total = total + (prod * cart[i]!);
    }
    final money = MoneyFormatter(
      amount: total,
      settings: MoneyFormatterSettings(
        thousandSeparator: ' ',
        symbol: 'tmt',
      ),
    ).output.symbolOnRight;
    return money;
  }

  void clearCart(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do u really want to clear'),
        icon: Icon(
          Icons.info_outline,
          size: 27.sp,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                  color: mainColor,
                )),
          ),
          TextButton(
            onPressed: () {
              cart.clear();
              trashBox.clear();
              Navigator.pop(context);
            },
            child: const Text('Yes',
                style: TextStyle(
                  color: mainColor,
                )),
          )
        ],
      ),
    );

    notik();
  }

  List<ProductModel> abcSort(List<ProductModel> models, trueSort) {
    final lang = langData!.language.value;
    for (var i in models) {
      // log('${i.titles['en']} beforeSort');
    }
    models.sort((a, b) =>
        a.titles[lang]!.toLowerCase().compareTo(b.titles[lang]!.toLowerCase()));
    log('abcSorted \n results');
    for (var i in models) {
      // log('${i.titles['en']} Afetr Sort');
    }

    if (trueSort) {
      return models;
    }
    return models.reversed.toList();
  }

  List<ProductModel> priceSort(List<ProductModel> models, bool trueSort) {
    // final lang = langData!.language.value;
    models.sort((a, b) => a.price.compareTo(b.price));
    log('priçe \n results');
    if (trueSort) {
      return models.reversed.toList();
    }
    return models;
  }

  List<ProductModel> justSort(List<ProductModel> models, SortType type) {
    if (type == SortType.news) {
      return models;
    }
    final sort = type == SortType.abcMirror || type == SortType.abcSort;
    if (sort) {
      return abcSort(models, type == SortType.abcSort);
    }
    log('here OSrt $type');

    return priceSort(models, type == SortType.priceSort);
  }
}
