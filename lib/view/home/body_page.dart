import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/item_view/item_menu_left.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/view/cart_detail_page.dart';
import 'package:flutter_project/view/detail_item_shop_page.dart';
import 'package:flutter_project/view/home/body_right_home.dart';
import 'package:toast/toast.dart';

class BodyPage extends StatefulWidget {
  BodyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> implements MenuLeftContract {

  var itemPos = 0;
  List<MenuLeft> menuLeft;
  MenuLeftPresenter menuLeftPresenter;
  Future<List<MenuLeft>> postItem;
  Future<List<BodyRight>> postRequest;

  bool _isShow = false;

  @override
  void initState() {
    menuLeftPresenter = new MenuLeftPresenter(this);
    postItem = menuLeftPresenter.getListData();
    super.initState();
  }

  void changeButtonState(int index, MenuLeft data) {
    setState(() {
      if (itemPos != index) {
        menuLeft[itemPos].isSelected = !menuLeft[itemPos].isSelected;
        if (menuLeft[itemPos].isSelected) {
          ItemMenuLeft(menu: data);
        } else {
          ItemMenuLeftFocus(menu: data);
        }
        itemPos = index;
        menuLeft[index].isSelected = !menuLeft[index].isSelected;
        if (menuLeft[index].isSelected) {
          ItemMenuLeft(menu: data);
        } else {
          ItemMenuLeftFocus(menu: data);
        }
        postRequest = menuLeftPresenter.getListBody(menuLeft[itemPos].category_name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemWidthCus = MediaQuery.of(context).size.width;
    var itemHeight = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    var widthLeft = ((itemWidthCus - (2 * (itemWidthCus * 0.08))) * 0.13) > 70 ? ((itemWidthCus - (2 * (itemWidthCus * 0.08))) * 0.13) : 70;

    return Container(
      margin: EdgeInsets.all(itemWidth * 0.02),
      height: itemHeight * 1.25,
      width: itemWidthCus,
      child: Row(
        children: [
          Container(
            width: widthLeft,
            child: FutureBuilder<List<MenuLeft>>(
                future: postItem,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return Text('No data found');
                      } else {
                        if (!snapshot.hasData) {
                          return Container();
                        }else{
                          menuLeft = new List();
                          menuLeft.add(MenuLeft('home', false));
                          menuLeft.addAll(snapshot.data);
                          menuLeft[itemPos].isSelected = true;
                        }
                        menuLeft[itemPos].isSelected = true;
                        return ListView.builder(
                          itemCount: menuLeft.length,
                          itemBuilder: (context, i) {
                            return menuLeft[i].isSelected ? InkWell(
                              hoverColor: Colors.white,
                              onTap: (){
                                changeButtonState(i, menuLeft[i]);
                              },
                              child: ItemMenuLeftFocus(menu: menuLeft[i], width: itemWidth),
                            ) : InkWell(
                              hoverColor: Colors.white,
                              onTap: (){
                                changeButtonState(i, menuLeft[i]);
                              },
                              child: ItemMenuLeft(menu: menuLeft[i], width: itemWidth,),
                            );
                          },
                        );
                      }
                  }
                },
              )
          ),
          Container(
            width: (itemWidthCus - (2 * (itemWidthCus * 0.08))) * 0.87,
            padding: EdgeInsets.only(left: itemWidthCus * 0.02),
            child: Stack(
              children: [
                itemPos == 0 ?
                ContainBodyHome(

                ) :
                ContainBodyRight(
                    width: itemWidthCus,
                    height: itemHeight,
                    postItem: postRequest,
                    menuLeftPresenter: menuLeftPresenter,
                    title: menuLeft[itemPos].category_name.toUpperCase()
                ),
                _isShow ? Center(
                  child: IndicatorProgress(),
                ) : Container()
              ],
            )
          )
        ],
      ),
    );
  }

  @override
  void goToDetail(BodyRight bodyRight) {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ItemDetailPage()
    ));
  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }

  @override
  void showToastMessage(String message) {
    Toast.show(message, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }

  @override
  void onSuccess() {
    setState(() {
      
    });
  }

  @override
  void onHideProgressDialog() {
    setState(() {
      _isShow = false;
    });
  }

  @override
  void onShowProgressDialog() {
    setState(() {
      _isShow = true;
    });
  }
}