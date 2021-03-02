import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ItemCartBody extends StatefulWidget{

  final double itemWidth;
  final double itemHeight;
  ItemCartBody({Key key, this.itemWidth, this.itemHeight}) : super(key: key);

  @override
  _ItemCartBody createState() => _ItemCartBody();

}

class _ItemCartBody extends State<ItemCartBody>{

  var textSize = 22.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: widget.itemWidth * 0.05, vertical: widget.itemHeight * 0.02),
            color: BLACK,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: widget.itemWidth * 0.2,
                      height: widget.itemWidth * 0.2,
                      color: Colors.white,
                    ),
                    Spacer(flex: 1),
                    Container(
                      child: Icon(
                        Icons.delete,
                        color: WHITE,
                        size: widget.itemWidth * 0.08,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.itemHeight * 0.02),
                Row(
                  children: [
                    Container(
                      child: textView('Name', WHITE, textSize, FontWeight.normal),
                    ),
                    Spacer(flex: 1,),
                    Container(
                      child: Row(
                        children: [
                          textView('-', WHITE, textSize, FontWeight.normal),
                          SizedBox(width: 12,),
                          textViewCenter('1', WHITE, textSize, FontWeight.bold),
                          SizedBox(width: 12,),
                          textView('+', WHITE, textSize, FontWeight.normal),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
        Divider(height: 2, color: WHITE)
      ],
    );
  }
}