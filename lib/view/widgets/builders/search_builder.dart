import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/constants/colors.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/language_data.dart';
import 'package:menu_app/data/main_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/productWidgets/product_widget.dart';

import 'product_builder.dart';

class SearchBuilder extends StatefulWidget {
  const SearchBuilder({super.key});

  @override
  State<SearchBuilder> createState() => _SearchBuilderState();
}

class _SearchBuilderState extends State<SearchBuilder> {
  static final data = getIt<MainData>(instanceName: 'mainData');
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  static final futures = getIt<Futures>(instanceName: 'futures');
  @override
  void initState() {
    super.initState();
    data.searchController.addListener(() async {
      final currentQuery = data.searchController.text;
      if (oldQuery == currentQuery) {
        return;
      }
      oldQuery = currentQuery;
      if (currentQuery.isEmpty) {
        doSearch = false;
        return;
      }
      final doIt = await futures.doSearch();
      doSearch = !doIt;
      log('$doIt search event ');
      if (doIt) {
        data.searchListener.value = !data.searchListener.value;
      }
    });
  }

  String oldQuery = '';
  @override
  void dispose() {
    super.dispose();
    data.searchController.text = '';
  }

  bool doSearch = false;

  final langData = getIt<LanguageData>(instanceName: 'langData');

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: data.searchListener,
        builder: (context, val, child) {
          return FutureBuilder(
              future: doSearch ? null : futures.search(),
              builder: (context, snap) {
                if (data.searchController.text.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'writeSome',
                      ),
                    ),
                  );
                }
                if (snap.connectionState != ConnectionState.done && !doSearch) {
                  return const Expanded(
                      child: Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  ));
                }
                if (data.searchController.text.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('writeSome'),
                    ),
                  );
                }
                final result = apiData.searchList;
                if (result.isEmpty) {
                  return const Expanded(
                      child: Center(
                    child: Text('empty'),
                  ));
                }
                return Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: data.sortChanges,
                      builder: (context, type, child) {
                        final prods = data.justSort(result, type);
                        return GridView.builder(
                          physics: mainPhysics,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent:
                                langData.language.value != 'ru' ? 230.h : 233.h,
                            mainAxisSpacing: 5.h,
                          ),
                          itemCount: prods.length,
                          itemBuilder: (context, index) => ProductWidget(
                            model: prods[index],
                            index: index,
                          ),
                        );
                      }),
                );
              });
        });
  }
}
