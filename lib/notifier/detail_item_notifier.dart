import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class DetailItemNotifier with ChangeNotifier, DiagnosticableTreeMixin {

  int _countItem = 1;

  int get countItem => _countItem;

  set countItem(int count) {
    _countItem = count;
    notifyListeners();
  }

  void updateCount(int count) {
  _countItem = count;
  notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', countItem));
  }
}