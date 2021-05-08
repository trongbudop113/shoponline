import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/menu_left.dart';

class MenuLeftNotifier with ChangeNotifier {
  List<MenuLeft> _categoryList = [];
  MenuLeft _currentCategory;
  int _index = 0;

  UnmodifiableListView<MenuLeft> get categoryList => UnmodifiableListView(_categoryList);

  MenuLeft get currentCategory => _currentCategory;
  int get currentIndex => _index;

  set categoryList(List<MenuLeft> categoryList) {
    _categoryList = categoryList;
    notifyListeners();
  }

  set currentCategory(MenuLeft menuLeft) {
    _currentCategory = menuLeft;
    notifyListeners();
  }

  set currentIndex(int index) {
    _index = index;
    notifyListeners();
  }

  addCategory(MenuLeft menuLeft) {
    _categoryList.insert(0, menuLeft);
    notifyListeners();
  }

  deleteCategory(MenuLeft category) {
    _categoryList.removeWhere((_category) => _category.id == category.id);
    notifyListeners();
  }
}
