import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemMenuLeft extends StatefulWidget {
  ItemMenuLeft({Key key, this.title, this.isFirst}) : super(key: key);
  final String title;
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
          textView(widget.title, Colors.black, 15, FontWeight.bold),
          Spacer(flex: 1,),
          Icon(Icons.home)
        ],
      ),
    );
  }
}