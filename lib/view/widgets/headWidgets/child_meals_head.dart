import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:menu_app/view/widgets/builders/child_category_builder.dart';
import 'package:menu_app/view/widgets/current_child_category_w_sort.dart';
import 'package:menu_app/view/widgets/pinned_container.dart';

class ChildCategoryHeadWidget extends StatelessWidget {
  const ChildCategoryHeadWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        haveShadow: true,
        color: Colors.white,
        height: 110.h,
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              width: double.infinity,
              height: 4.h,
            ),
            const ChildCategoryBuilder(),
            const CurretnCategoryWSort(),
          ],
        ),
      ),
    );
  }
}
