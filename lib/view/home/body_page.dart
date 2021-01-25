import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/item_view/item_body_right.dart';
import 'package:flutter_project/item_view/item_menu_left.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/widget/text_widget.dart';

class BodyPage extends StatefulWidget {
  BodyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {

  var itemPos = 0;
  List<MenuLeft> menuLeft;

  @override
  void initState() {
    super.initState();
    menuLeft = MenuLeft().getListData();
    menuLeft[itemPos].isSelected = true;
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
            child: ListView.builder(
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
            ),
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
}

class ContainBodyRight extends StatefulWidget {
  ContainBodyRight({Key key, this.title, this.width, this.height}) : super(key: key);
  final String title;
  final double width, height;

  @override
  _ContainBodyRightState createState() => _ContainBodyRightState();
}

class _ContainBodyRightState extends State<ContainBodyRight> {

  List<int> itemList = [1, 2, 3, 4 ,5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

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
            child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: widget.height * 0.05,
            mainAxisSpacing: widget.width * 0.02,
            childAspectRatio: 9 / 12,
            children: itemList.map((int) => ItemBodyRight()).toList(),
           )
          )
        ],
      ),
    );
  }
}