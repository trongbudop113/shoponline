import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemBodyRight extends StatefulWidget {
  ItemBodyRight({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ItemBodyRightState createState() => _ItemBodyRightState();
}

class _ItemBodyRightState extends State<ItemBodyRight> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
    );
  }
}