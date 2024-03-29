import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/body_right.dart';

class BodyRightNotifier with ChangeNotifier {
  List<BodyRight> _productList = [];
  BodyRight _currentProduct;
  String _currentColor;
  String _currentSize;
  bool _isLoading = false;
  int _paging = 1;

  UnmodifiableListView<BodyRight> get productList => UnmodifiableListView(_productList);

  BodyRight get currentProduct => _currentProduct;
  String get currentColor => _currentColor;
  String get currentSize => _currentSize;
  bool get currentLoading => _isLoading;
  int get paging => _paging;

  set paging(int paging) {
    _paging = paging;
    notifyListeners();
  }

  set productList(List<BodyRight> productList) {
    _productList = productList;
    notifyListeners();
  }

  set currentLoading(bool isLoad) {
    _isLoading = isLoad;
    notifyListeners();
  }

  set currentProduct(BodyRight bodyRight) {
    _currentProduct = bodyRight;
    notifyListeners();
  }

  set currentColor(String currentColor) {
    _currentColor = currentColor;
    notifyListeners();
  }

  set currentSize(String currentSize) {
    _currentSize = currentSize;
    notifyListeners();
  }

  addFood(BodyRight bodyRight) {
    _productList.insert(0, bodyRight);
    notifyListeners();
  }

  deleteFood(BodyRight bodyRight) {
    _productList.removeWhere((_product) => _product.id == bodyRight.id);
    notifyListeners();
  }

  // static Future<dynamic> loadFromStorage(BuildContext context, String image) async {
  //   var url = await storage().ref(image).getDownloadURL();
  //   return url;
  // }
}
