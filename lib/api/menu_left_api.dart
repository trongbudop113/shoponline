import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/cart.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/menu_left_notifier.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

getCategoryData(MenuLeftNotifier menuLeftNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CATEGORY).getDocuments();

  List<MenuLeft> _categoryList = [];

  snapshot.documents.forEach((document) {
    MenuLeft menuLeft = MenuLeft.fromMap(document.data);
    _categoryList.add(menuLeft);
  });

  menuLeftNotifier.categoryList = _categoryList;
}

getCountCart(AuthNotifier authNotifier, CartNotifier cartNotifier) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool intValue = prefs.getBool(Common.LOGIN) ?? false;
  if(intValue){
    String uid = prefs.getString(Common.UUID) ?? '';
    var snapshot = await Firestore.instance.collection(DatabaseCollection.ALL_CART).document(uid).collection(uid).getDocuments();
    authNotifier.count = snapshot.documents.length;

    List<CartItem> _listCart = [];

    snapshot.documents.forEach((document) {
      var item = CartItem.fromMap(document.data);
      _listCart.add(item);
    });
    cartNotifier.cartList = _listCart;
  }else{
    authNotifier.count = 0;
  }
}

getProductsData(BodyRightNotifier bodyRightNotifier, MenuLeft products) async {
  bodyRightNotifier.currentLoading = true;
  QuerySnapshot snapshot = await Firestore.instance
      .collection(DatabaseCollection.ALL_PRODUCT)
      .orderBy("createdAt", descending: true).where('category', isEqualTo: '${products.id}')
      .getDocuments();

  List<BodyRight> _productList = [];

  snapshot.documents.forEach((document) {
    BodyRight food = BodyRight.fromMap(document.data);
    _productList.add(food);
  });

  bodyRightNotifier.currentLoading = false;
  bodyRightNotifier.productList = _productList;
}

uploadFoodAndImage(BodyRight food, bool isUpdating, File localFile, Function foodUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('products/images/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadFood(food, isUpdating, foodUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadFood(food, isUpdating, foodUploaded);
  }
}

_uploadFood(BodyRight food, bool isUpdating, Function foodUploaded, {String imageUrl}) async {
  CollectionReference foodRef = Firestore.instance.collection('all_products');

  if (imageUrl != null) {
    food.image = imageUrl;
  }

  if (isUpdating) {
    food.updatedAt = Timestamp.now();

    await foodRef.document(food.id).updateData(food.toMap());

    foodUploaded(food);
    print('updated food with id: ${food.id}');
  } else {
    food.createdAt = Timestamp.now();

    DocumentReference documentRef = await foodRef.add(food.toMap());

    food.id = documentRef.documentID;

    print('uploaded food successfully: ${food.toString()}');

    await documentRef.setData(food.toMap(), merge: true);

    foodUploaded(food);
  }
}

deleteFood(BodyRight bodyRight, Function foodDeleted) async {
  if (bodyRight.image != null) {
    StorageReference storageReference =
    await FirebaseStorage.instance.getReferenceFromUrl(bodyRight.image);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await Firestore.instance.collection('all_products').document(bodyRight.id).delete();
  foodDeleted(bodyRight);
}
