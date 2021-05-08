import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/body_right.dart';

class BodyRightNotifier with ChangeNotifier {
  List<BodyRight> _productList = [];
  BodyRight _currentProduct;
  bool _isLoading = false;

  UnmodifiableListView<BodyRight> get productList => UnmodifiableListView(_productList);

  BodyRight get currentProduct => _currentProduct;
  bool get currentLoading => _isLoading;

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
