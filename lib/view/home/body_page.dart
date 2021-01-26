import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/item_view/item_body_right.dart';
import 'package:flutter_project/item_view/item_menu_left.dart';
import 'package:flutter_project/model/body_right.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/presenter/home/body_presenter.dart';
import 'package:flutter_project/presenter/home/menu_left_presenter.dart';
import 'package:flutter_project/widget/text_widget.dart';

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
            child: ContainBodyRight(width: itemWidth, height: itemHeight,),
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

class ContainBodyRight extends StatefulWidget {
  ContainBodyRight({Key key, this.title, this.width, this.height}) : super(key: key);
  final String title;
  final double width, height;

  @override
  _ContainBodyRightState createState() => _ContainBodyRightState();
}

class _ContainBodyRightState extends State<ContainBodyRight> implements BodyContract {

  BodyPresenter bodyPresenter;
  Future<List<BodyRight>> postItem;

  @override
  void initState() {
    bodyPresenter = new BodyPresenter(this);
    postItem = bodyPresenter.getListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: textView('COATS', Colors.black, 35, FontWeight.bold),
          ),
          SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerLeft,
            child: textView('View more', Colors.black, 12, FontWeight.bold),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all()
                ),
                child: Container(
                  width: 100,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.sort),
                      textView('Sort', Colors.black, 12, FontWeight.normal)
                    ],
                  ),
                )
              ),
              SizedBox(width: 20,),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all()
                  ),
                  child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: textView('Product Type', Colors.black, 12, FontWeight.normal)
                  )
              ),
              SizedBox(width: 20,),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all()
                  ),
                  child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: textView('Style', Colors.black, 12, FontWeight.normal)
                  )
              ),
              SizedBox(width: 20,),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all()
                  ),
                  child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: textView('Size', Colors.black, 12, FontWeight.normal)
                  )
              ),
              SizedBox(width: 20,),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      border: Border.all()
                  ),
                  child: Container(
                      width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: textView('Colors', Colors.black, 12, FontWeight.normal)
                  )
              )
            ],
          ),
          SizedBox(height: 20,),
          Expanded(
            child: FutureBuilder<List<BodyRight>>(
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
                      if (!snapshot.hasData) return Container();
                      return GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: widget.height * 0.05,
                        mainAxisSpacing: widget.width * 0.02,
                        childAspectRatio: 9 / 12,
                        children: snapshot.data.map((int) => ItemBodyRight(item: int)).toList(),
                      );
                    }
                }
              },
            )
          )
        ],
      ),
    );
  }

  @override
  void goToDetail(BodyRight bodyRight) {

  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }
}