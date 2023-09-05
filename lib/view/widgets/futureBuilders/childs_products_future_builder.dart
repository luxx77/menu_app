import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:menu_app/api/get_futures.dart';
import 'package:menu_app/data/api_data.dart';
import 'package:menu_app/main.dart';
import 'package:menu_app/models/product_model.dart';
import 'package:menu_app/view/widgets/builders/product_builder.dart';

class ChildsProductBuilder extends StatefulWidget {
  ChildsProductBuilder({super.key});

  @override
  State<ChildsProductBuilder> createState() => _ChilProddAndRecsProStBuilder();
}

class _ChilProddAndRecsProStBuilder extends State<ChildsProductBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final apiData = getIt<ApiData>(instanceName: 'apiData');
  final futures = getIt<Futures>(instanceName: 'futures');
  int? theChild;
  @override
  Widget build(BuildContext context) {
    theChild = apiData.currentChildId.value;
    final getted = apiData.gettedChilds[theChild] != null;
    log('Bulders');
    return FutureBuilder(
      future: getted ? null : futures.getProductsByChild(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done && !getted) {
          return ProductBuilder();
        }
        if (snap.hasError || apiData.gettedChilds[theChild]!.isEmpty) {
          return const Center(
            child: Text(
              'ERRORRORORO',
            ),
          );
        }
        return ProductBuilder(
          products: apiData.gettedChilds[theChild]! as List<ProductModel>,
        );
      },
    );
  }
}
