import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/values/string_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class AcceptDialog extends StatefulWidget {

  String msg;
  String title;

  AcceptDialog({this.title, this.msg});

  @override
  _AcceptDialogState createState() => _AcceptDialogState();
}

class _AcceptDialogState extends State<AcceptDialog> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  var greyColorText = Colors.grey;
  var colorTextTitle = Colors.black;
  var greyBorderColor = Colors.grey[200];
  var sizeText = 16.0;


  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    print(widget.msg.length);
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemWidth = (Common.isPortrait(context) ? size.width : size.height) * 0.9;
    final double itemHeight = (Common.isPortrait(context) ? size.height : size.width) * (widget.msg.length > 100 ? 0.4 : (Common.isPortrait(context) ? 0.29 : 0.33));


    return Dialog(
        child: Container(
            width: itemWidth,
            height: ((widget.msg.length / 20) * 25) + 150,
            color: Colors.grey[200],
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(itemWidth * 0.04),
                  child: textView(widget.title, Colors.black, 22, FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: textViewCenter(widget.msg, Colors.black, 20, FontWeight.normal),
                ),
                Spacer(flex: 1,),
                Divider(),
                Container(
                  width: itemWidth,
                  height: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 50,
                          width: (itemWidth / 2) - 18,
                          alignment: Alignment.center,
                          child: textViewCenter(PageName.no, BLACK, 20, FontWeight.bold),
                        ),
                        onTap: (){
                          Navigator.pop(context, "No");
                        },
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        child: VerticalDivider(),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          width: (itemWidth / 2) - 18,
                          alignment: Alignment.center,
                          child: textViewCenter(PageName.yes, BLACK, 20, FontWeight.bold),
                        ),
                        onTap: (){
                          Navigator.pop(context, "Yes");
                        },
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}