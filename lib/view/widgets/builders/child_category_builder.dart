import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/data/notifier.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/view/widgets/error_widget.dart';

import '../productWidgets/child_category_widget.dart';

class ChildCategoryBuilder extends StatelessWidget {
  const ChildCategoryBuilder({super.key});

  static final apiData = getIt<ApiData>(instanceName: 'apiData');
  static final futures = getIt<Futures>(instanceName: 'futures');
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TryNotifier>(context);
    final getted = apiData.childs[apiData.currentParentId!] != null;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      height: 58.h,
      child: FutureBuilder(
          future: getted ? null : futures.getChilds(),
          builder: (context, snap) {
            final waiting = snap.connectionState == ConnectionState.waiting;
            if (waiting && !getted) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChildCategoryWidget(
                    index: index,
                  );
                },
              );
            }
            if (snap.hasError ||
                apiData.childs[apiData.currentParentId!] == null) {
              return const MyErrorWidget();
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: apiData.childs[apiData.currentParentId!]!.length,
              itemBuilder: (context, index) {
                return ChildCategoryWidget(
                  index: index,
                  model: apiData.childs[apiData.currentParentId]![index],
                );
              },
            );
          }),
    );
  }
}
