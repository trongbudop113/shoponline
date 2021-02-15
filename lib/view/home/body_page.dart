import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/item_view/item_menu_left.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/view/home/body_right_home.dart';

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
          ItemMenuLeft(menu: data, isFirst: index == 0 ? true : false);
        } else {
          ItemMenuLeftFocus(menu: data, isFirst: index == 0 ? true : false);
        }
        itemPos = index;
        menuLeft[index].isSelected = !menuLeft[index].isSelected;
        if (menuLeft[index].isSelected) {
          ItemMenuLeft(menu: data, isFirst: index == 0 ? true : false);
        } else {
          ItemMenuLeftFocus(menu: data, isFirst: index == 0 ? true : false);
        }
        postRequest = menuLeftPresenter.getListBody(menuLeft[itemPos].category_name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      height: itemHeight * 0.8,
      width: itemWidth,
      child: Row(
        children: [
          Container(
            width: (itemWidth - (2 * (itemWidth * 0.08))) * 0.13,
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
                              child: ItemMenuLeftFocus(menu: menuLeft[i], isFirst: i == 0 ? true : false),
                            ) : InkWell(
                              hoverColor: Colors.white,
                              onTap: (){
                                changeButtonState(i, menuLeft[i]);
                              },
                              child: ItemMenuLeft(menu: menuLeft[i], isFirst: i == 0 ? true : false),
                            );
                          },
                        );
                      }
                  }
                },
              )
          ),
          Container(
            height: itemHeight * 0.8,
            width: (itemWidth - (2 * (itemWidth * 0.08))) * 0.87,
            padding: EdgeInsets.only(left: itemWidth * 0.02),
            child: itemPos == 0 ? ContainBodyHome() :
            ContainBodyRight(width: itemWidth, height: itemHeight, postItem: postRequest, menuLeftPresenter: menuLeftPresenter),
          )
        ],
      ),
    );
  }

  @override
  void goToDetail(MenuLeft menuLeft) {

  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }
}