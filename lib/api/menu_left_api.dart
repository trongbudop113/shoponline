
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/menu_left_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

getCategoryData(MenuLeftNotifier menuLeftNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CATEGORY).get();

  List<MenuLeft> _categoryList = [];

  snapshot.docs.forEach((document) {
    MenuLeft menuLeft = MenuLeft.fromMap(document.data());
    _categoryList.add(menuLeft);
  });

  menuLeftNotifier.categoryList = _categoryList;
}

getUserData(AuthNotifier authNotifier) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool intValue = prefs.getBool(Common.LOGIN) ?? false;
  if(intValue){
    String uid = prefs.getString(Common.UUID) ?? '';
    var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_USER).doc(uid).get();
    authNotifier.userData = UserData.fromMap(snapshot.data());
  }else{
    authNotifier.count = 0;
  }
}

getCountCart(AuthNotifier authNotifier, CartNotifier cartNotifier) async{
  //cartNotifier.currentLoading = true;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool intValue = prefs.getBool(Common.LOGIN) ?? false;
  if(intValue){
    String uid = prefs.getString(Common.UUID) ?? '';
    var snapshot = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_CART).doc(uid).collection(uid).get();
    var snapshotUser = await FirebaseFirestore.instance.collection(DatabaseCollection.ALL_USER).doc(uid).get();
    authNotifier.count = snapshot.docs.length;
    authNotifier.userData = UserData.fromMap(snapshotUser.data());


    CartTotalItem cartTotalItem = CartTotalItem();
    List<CartItem> _listCart = [];
    var totalPrice = 0.0;
    snapshot.docs.forEach((document) {
      var item = CartItem.fromMap(document.data());
      totalPrice = totalPrice + (double.parse(item.price.toString()) * item.quantity);
      _listCart.add(item);
    });
    cartTotalItem.cartItems = _listCart;
    cartTotalItem.total = totalPrice.toString();
    cartTotalItem.status = 'Create';
    cartTotalItem.code = '';
    cartTotalItem.discount = '0';
    cartTotalItem.totalFinal = totalPrice - double.parse(cartTotalItem.discount);

    //cartNotifier.cartList = _listCart;
    cartNotifier.cartTotalItem = cartTotalItem;
    cartNotifier.currentLoading = false;
  }
}

getProductsData(BodyRightNotifier bodyRightNotifier, MenuLeft products) async {
  bodyRightNotifier.currentLoading = true;
  var snapshot = FirebaseFirestore.instance
      .collection(DatabaseCollection.ALL_PRODUCT)
      .orderBy("createdAt", descending: true).where('category', isEqualTo: '${products.id}');

  QuerySnapshot data1 = await snapshot.limit(4).get();
  QuerySnapshot data2 = await snapshot.get();

  List<BodyRight> _productList = [];

  bodyRightNotifier.paging = data2.docs.length ~/ 4 + 1;

  data1.docs.forEach((document) {
    BodyRight food = BodyRight.fromMap(document.data());
    _productList.add(food);
  });

  bodyRightNotifier.currentLoading = false;
  bodyRightNotifier.productList = _productList;
}

