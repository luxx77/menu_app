import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/enums/sort_enum.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/category_model.dart';
import 'package:menu_app/models/product_model.dart';

class ApiData {
  LanguageData? langData;
  void init() {
    langData = getIt<LanguageData>(instanceName: 'langData');
  }

  List<CategoryModel>? parents;
  Map<int, List<CategoryModel>> childs = {};
  Map<int, List<ProductModel>> gettedChilds = {};
  List<ProductModel> allProds = [];
  List<ProductModel> searchList = [];
  int? currentParentId;
  final currentChildId = ValueNotifier<int?>(null);
  int? crrentTheProduct;

 
}
