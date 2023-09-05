import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:menu_app/constants/api_url.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/category_model.dart';
import 'package:menu_app/models/product_model.dart';

class Futures {
  final dio = Dio();
  ApiData? apiData;
  MainData? mainData;
  void init() {
    apiData = getIt<ApiData>(instanceName: 'apiData');
    mainData = getIt<MainData>(instanceName: 'mainData');
  }

  int searchInt = 0;
  Future<bool> doSearch() async {
    final query = mainData!.searchController.text;
    final myInt = searchInt;
    searchInt++;
    await Future.delayed(const Duration(milliseconds: 500), () {});
    if ((myInt + 1) != searchInt) {
      return false;
    }
    final currentQuery = mainData!.searchController.text;
    if (currentQuery != query || query.contains('#')) {
      apiData!.searchList = List.empty();
      return false;
    }
    log('"$query" theQurey');
    return true;
  }

  Future search() async {
    final query = mainData!.searchController.text;
    try {
      final data = await dio.get('$mainUrl$searchUrl$query');
      log('${data.data}');
      apiData!.searchList = List.from(ProductModel.fromList(data.data));
      for (var i in apiData!.searchList) {
        addToAll(i);
      }
      mainData!.searchTitleListener.value =
          !mainData!.searchTitleListener.value;
      return 1;
    } catch (e) {
      apiData!.searchList = List.empty();
      return 1;
    }
  }

  Future getParents() async {
    if (apiData!.parents != null) {
      return;
    }

    try {
      final data = await dio.get('$mainUrl$parentsUrl');
      final statusCode = data.statusCode;
      if (statusCode != 200) {
        apiData!.parents = List.empty();
        return;
      }
      apiData!.parents = CategoryModel.fromList(data.data);
    } catch (e) {
      // apiData!.parents = List.empty();
      log('$e \ngetParentsError');
      return;
    }
  }

  Future getChilds() async {
    final parentId = apiData!.currentParentId;
    final theChild = apiData!.childs[parentId];
    if (theChild != null) {
      return;
    }
    try {
      final data = await dio.get('$mainUrl$childUrl$parentId/');
      final statusCode = data.statusCode;
      if (statusCode != 200) {
        return;
      }
      apiData!.childs[parentId!] = CategoryModel.fromList(data.data);
      apiData!.currentChildId.value = 6666;
      apiData!.currentChildId.value = data.data.first['id'];
      for (var i in apiData!.childs[parentId]!) {
        // log(CategoryModel.toMap(i).toString());
      }
    } catch (e) {
      log('$e \ngetChilds Error');
    }
  }

  Future<int> getProductsByChild() async {
    final theChildId = apiData!.currentChildId.value;
    log('rowsenin ejesi yok');
    if (apiData!.gettedChilds[theChildId] != null) {
      return 1;
    }
    try {
      final data = await dio.get('$mainUrl$productFromChildUrl$theChildId/');
      if (data.statusCode != 200) {
        apiData!.gettedChilds[theChildId!] = List.empty();
        return 1;
      }
      final prods = ProductModel.fromList(data.data);
      apiData!.gettedChilds[theChildId!] = List.from(prods);
      for (var i in apiData!.gettedChilds[theChildId]!) {
        addToAll(i);
        // log(ProductModel.toMap(i).toString());
      }
      return 0;
    } catch (e) {
      log('$e \n getProductsByChild Error');
      apiData!.gettedChilds[theChildId!] = List.empty();
      return 1;
    }
  }

  Future getRecsByProdId() async {
    final theProdId = apiData!.crrentTheProduct!;
    // log('gettingID $theProdId');
    final theIndex = findProdById(theProdId);
    if (apiData!.allProds[theIndex].recs != null) {
      return;
    }
    try {
      final data = await dio.get('$mainUrl$recsByProdIdUrl$theProdId');
      final statusCode = data.statusCode;
      if (data.statusCode != 200) {
        return;
      }
      final prods = ProductModel.fromList(data.data);
      apiData!.allProds[theIndex].recs = List.from(prods);
      log('recsGetted');
      log('${data.data} \n data');
      // addGettedProd(prods);
      for (var i in apiData!.allProds[theIndex].recs!) {
        addToAll(i);
        log('$theIndex ${ProductModel.toMap(i).toString()}');
      }
    } catch (e) {
      log('$e \n GetREcsError');
      return 6666;
    }
  }

  Future getTheProduct() async {
    log('gettingTheProd');
    // return 6666;
    final theProdId = apiData!.crrentTheProduct;

    try {
      // log('$mainUrl$theProductUrl$theProdId/');
      final data = await dio.get('$mainUrl$theProductUrl$theProdId/');
      if (data.statusCode != 200) {
        return;
      }
      log('${data.data} \n TheProod');

      final gettedProd = ProductModel.fromMap(data.data);
      apiData!.allProds[findProdById(gettedProd.id)] = gettedProd;
      // log(ProductModel.toMap(gettedProd).toString());
    } catch (e) {
      log('$e \n getThePRod Error');
      return 6666;
    }
  }

  int findProdById(int id) {
    for (int i = 0; i < apiData!.allProds.length; i++) {
      if (apiData!.allProds[i].id == id) {
        return i;
      }
    }
    return 6666;
  }

  void addToAll(ProductModel model) {
    bool doIt = true;
    apiData!.allProds.forEach((element) {
      if (element == model) {
        doIt = false;
      }
    });
    if (doIt) {
      apiData!.allProds.add(model);
    }
  }
}
