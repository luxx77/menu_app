import 'package:flutter/widgets.dart';

class TryNotifier with ChangeNotifier {
  void notifi() {
    notifyListeners();
  }
}
