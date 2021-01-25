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

  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      border: Border.all(color: Colors.purple[200])
                    ),
                    child: textView('50%', Colors.purple[200], 15, FontWeight.bold),
                  ),
                  Spacer(flex: 1),
                  IconButton(icon: new Icon(Icons.favorite, size: 30),onPressed: ()=>setState((){}))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(icon: new Icon(Icons.remove_circle_outline),onPressed: ()=>setState(() => _itemCount > 0 ? _itemCount -- : 0)),
                  textView(_itemCount.toString(), Colors.purple[200], 18, FontWeight.bold),
                  IconButton(icon: new Icon(Icons.add_circle_outline_rounded),onPressed: ()=>setState(()=>_itemCount >= 0 ? _itemCount ++ : 0)),
                  Spacer(flex: 1),
                  IconButton(icon: new Icon(Icons.add_shopping_cart),onPressed: ()=>setState((){}))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}