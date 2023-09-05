import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/notifier.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/productWidgets/parent_category_widget.dart';

class ParentCategoryBuilder extends StatelessWidget {
  const ParentCategoryBuilder({super.key});
  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  static final futures = getIt<Futures>(instanceName: 'futures');
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TryNotifier>(context);
    final getted = apiData.parents != null;
    log('parentsRebuild');
    return FutureBuilder(
      future: getted ? null : futures.getParents(),
      builder: (context, snap) {
        final waiting = snap.connectionState != ConnectionState.done;
        if (waiting && !getted) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ParentCategoryWidget(
                  index: index,
                );
              },
            ),
          );
        }
        if (apiData.parents == null ||
            snap.hasError ||
            apiData.parents!.isEmpty) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 600.h,
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      provider.notifi();
                    },
                    child: const Text('SomeThings went Wrong \ Try again')),
              ),
            ),
          );
        }
        log('${apiData.parents!.length} parentLength');
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ParentCategoryWidget(
                model: apiData.parents![index],
                index: index,
              );
            },
            childCount: apiData.parents!.length,
          ),
        );
      },
    );
  }
}
