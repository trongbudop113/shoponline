import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemSortProduct extends StatefulWidget {
  ItemSortProduct({Key key, this.name}) : super(key: key);
  final String name;

  @override
  _ItemSortProductState createState() => _ItemSortProductState();
}

class _ItemSortProductState extends State<ItemSortProduct> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      color: BLACK,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(Icons.sort, color: WHITE),
          SizedBox(width: 10,),
          textView(widget.name, WHITE, 12, FontWeight.normal)
        ],
      ),
    );
  }
}

class ItemFilterProduct extends StatefulWidget {
  ItemFilterProduct({Key key, this.name}) : super(key: key);
  final String name;

  @override
  _ItemFilterProductState createState() => _ItemFilterProductState();
}

class _ItemFilterProductState extends State<ItemFilterProduct> {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: BLACK,
        margin: EdgeInsets.only(left: 20),
        child: Container(
            width: 100,
            height: 40,
            alignment: Alignment.center,
            child: textView(widget.name, WHITE, 12, FontWeight.normal)
        )
    );
  }
}