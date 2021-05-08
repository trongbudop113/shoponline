import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/model/favorite.dart';
import 'package:flutter_project/presenter/favorite/favorite_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> implements FavoriteContract {

  FavoritePresenter favoritePresenter;
  List<FavoriteItem> listFavoriteItem = new List();
  var _firebaseAuth = FirebaseAuth.instance;

  // Future<void> getListCart() async{
  //   onShowProgressDialog();
  //   Firestore store = firestore();
  //   CollectionReference ref = store.collection(DatabaseCollection.ALL_WISH_LIST);
  //   var document = ref.doc(_firebaseAuth.currentUser.uid).collection(_firebaseAuth.currentUser.uid);
  //   document.onSnapshot.listen((querySnapshot) {
  //     querySnapshot.docChanges().forEach((change) {
  //       if (change.type == "added") {
  //         Map<String, dynamic> a = change.doc.data();
  //         var item = FavoriteItem.fromJson(a);
  //         listFavoriteItem.add(item);
  //       }
  //     });
  //   });
  //   onGetDataSuccess();
  // }

  @override
  void initState() {
    favoritePresenter = new FavoritePresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    Widget yourWishList(){
      return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
            child: textView('Danh sách yêu thích của bạn:', BLACK, 22, FontWeight.normal),
          )
      );
    }

    Widget totalPayment(){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.05),
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              textView('Thành tiền: ' + '100.000', BLACK, 20, FontWeight.normal),
              textView('Giảm giá: ' + '20.000', BLACK, 20, FontWeight.normal),
              textView('Tổng: ' + '80.000', BLACK, 20, FontWeight.normal),
            ],
          ),
        ),
      );
    }

    Widget paymentCart(){
      return SliverToBoxAdapter(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(itemWidth * 0.05),
            color: BLACK,
            height: 50,
            child: textView('Thanh toán', WHITE, 20, FontWeight.normal),
          ),
          onTap: (){
            setState(() {

            });
          },
        ),
      );
    }

    Widget spaceHeight(double space){
      return SliverToBoxAdapter(
        child: SizedBox(height: itemHeight * space),
      );
    }

    Widget listCart(bool isPortrait){
      return SliverPadding(
          padding: isPortrait ? EdgeInsets.symmetric(horizontal: itemWidth * 0.05) : EdgeInsets.all(itemWidth * 0.05),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) =>
                  Container(
                    color: BLACK,
                  ),
                childCount: 5,
              )
          )
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: BLACK,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 50,
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, size: 30, color: WHITE),
                ),
              ),
            ),
            Spacer(flex: 1,),
            Container(
              alignment: Alignment.center,
              child: textViewCenter('WEARISM', WHITE, 28, FontWeight.bold),
            ),
            Spacer(flex: 1,),
            InkWell(
              onTap: (){

              },
              child: Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Icon(Icons.shopping_cart, size: 30, color: WHITE),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: textView('0', WHITE, 18, FontWeight.normal),
                      )
                    ],
                  )
              ),
            ),
            SizedBox(width: 15)
          ],
        ),
        body: Container(
          width: itemWidth,
          child: !Common.isPortrait(context) ?
          Container(
            child: Row(
              children: [
                Container(
                  width: itemWidth * 0.6,
                  height: itemHeight,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      spaceHeight(0.02),
                      yourWishList(),
                      spaceHeight(0.02),
                      listCart(true),
                      spaceHeight(0.02),
                    ],
                  ),
                ),
                Container(
                  width: itemWidth * 0.4,
                  height: itemHeight,
                  child: CustomScrollView(
                    slivers: [
                      spaceHeight(0.1),
                      totalPayment(),
                      spaceHeight(0.05),
                      paymentCart(),
                    ],
                  ),
                )
              ],
            ),
          ) :
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              spaceHeight(0.02),
              yourWishList(),
              listCart(false),
              spaceHeight(0.05),
              totalPayment(),
              paymentCart()
            ],
          ),
        )

    );
  }

  @override
  void onDeleteSuccess() {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onGetDataSuccess() {
    // TODO: implement onGetDataSuccess
  }

  @override
  void onHideProgressDialog() {
    // TODO: implement onHideProgressDialog
  }

  @override
  void onShowProgressDialog() {
    // TODO: implement onShowProgressDialog
  }

  @override
  void onUpdateSuccess(FavoriteItem favoriteItem) {
    // TODO: implement onUpdateSuccess
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {
    // TODO: implement showMessageError
  }
}