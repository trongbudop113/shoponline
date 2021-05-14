import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/model/favorite.dart';

class FavoriteNotifier with ChangeNotifier {
  List<FavoriteItem> _favoriteList = [];
  FavoriteItem _currentItemFavorite;
  int _favoriteCount = 0;
  bool _isLoading = false;

  UnmodifiableListView<FavoriteItem> get favoriteList => UnmodifiableListView(_favoriteList);

  FavoriteItem get currentItemFavorite => _currentItemFavorite;
  bool get currentLoading => _isLoading;
  int get favoriteCount => _favoriteCount;

  set favoriteList(List<FavoriteItem> favoriteList) {
    _favoriteList = favoriteList;
    notifyListeners();
  }

  set favoriteCount(int favoriteCount) {
    _favoriteCount = favoriteCount;
    notifyListeners();
  }

  set currentLoading(bool isLoad) {
    _isLoading = isLoad;
    notifyListeners();
  }

  set currentItemFavorite(FavoriteItem favoriteItem) {
    _currentItemFavorite = favoriteItem;
    notifyListeners();
  }
}
