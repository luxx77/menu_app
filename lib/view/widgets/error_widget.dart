import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:menu_app/data/notifier.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () {
        final provider = Provider.of<TryNotifier>(context, listen: false);
        provider.notifi();
      },
      child: Text(
        ' Error I am sorrry,',
      ),
    ));
  }
}
