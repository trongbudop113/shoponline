import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemMenuLeft extends StatefulWidget {
  ItemMenuLeft({Key key, this.menu}) : super(key: key);
  final MenuLeft menu;

  @override
  _ItemMenuLeftState createState() => _ItemMenuLeftState();
}

class _ItemMenuLeftState extends State<ItemMenuLeft> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: BLACK,
      padding: EdgeInsets.all(12),
      child: !Common.isPortrait(context) ?
      Row(
        children: [
          textView(widget.menu.category_name.toUpperCase(), WHITE, 15, FontWeight.bold),
          Spacer(flex: 1,),
          Icon(Icons.home, color: WHITE,)
        ],
      ) :
      Column(
        children: [
          Icon(Icons.home, color: WHITE,),
          textView(widget.menu.category_name.toUpperCase(), WHITE, 5, FontWeight.bold),
        ],
      ),
    );
  }
}

class ItemMenuLeftFocus extends StatefulWidget {
  ItemMenuLeftFocus({Key key, this.menu}) : super(key: key);
  final MenuLeft menu;

  @override
  _ItemMenuLeftFocusState createState() => _ItemMenuLeftFocusState();
}

class _ItemMenuLeftFocusState extends State<ItemMenuLeftFocus> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(12),
      child: !Common.isPortrait(context) ?
      Row(
        children: [
          textView(widget.menu.category_name.toUpperCase(), BLACK, 15, FontWeight.bold),
          Spacer(flex: 1,),
          Icon(Icons.home, color: BLACK)
        ],
      ) :
      Column(
        children: [
          Icon(Icons.home, color: BLACK),
          textView(widget.menu.category_name.toUpperCase(), BLACK, 5, FontWeight.bold),
        ],
      ),
    );
  }
}