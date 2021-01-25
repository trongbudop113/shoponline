import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/model/menu_left.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemMenuLeft extends StatefulWidget {
  ItemMenuLeft({Key key, this.menu, this.isFirst}) : super(key: key);
  final MenuLeft menu;
  final bool isFirst;

  @override
  _ItemMenuLeftState createState() => _ItemMenuLeftState();
}

class _ItemMenuLeftState extends State<ItemMenuLeft> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isFirst ? null : 70,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          textView(widget.menu.category_name.toUpperCase(), Colors.black, 15, FontWeight.bold),
          Spacer(flex: 1,),
          Icon(Icons.home)
        ],
      ),
    );
  }
}

class ItemMenuLeftFocus extends StatefulWidget {
  ItemMenuLeftFocus({Key key, this.menu, this.isFirst}) : super(key: key);
  final MenuLeft menu;
  final bool isFirst;

  @override
  _ItemMenuLeftFocusState createState() => _ItemMenuLeftFocusState();
}

class _ItemMenuLeftFocusState extends State<ItemMenuLeftFocus> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isFirst ? null : 70,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent[100],
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          textView(widget.menu.category_name.toUpperCase(), Colors.pinkAccent[100], 15, FontWeight.bold),
          Spacer(flex: 1,),
          Icon(Icons.home, color: Colors.pinkAccent[100])
        ],
      ),
    );
  }
}