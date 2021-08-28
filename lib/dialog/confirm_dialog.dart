import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/string_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class ConfirmDialog extends StatefulWidget {

  String msg;
  String title;

  ConfirmDialog({this.title, this.msg});

  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> with SingleTickerProviderStateMixin {
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

    var heightDialog = itemHeight * 0.03;

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
            width: itemWidth,
            height: ((widget.msg.length / 20) * 25) + 150,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(itemWidth * 0.04),
                  child: textView(widget.title, Colors.black, 20, FontWeight.bold),
                ),
                Container(
                  child: textViewCenter(widget.msg, Colors.black, 20, FontWeight.normal),
                ),
                Spacer(flex: 1,),
                Divider(),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0)),
                        color: Colors.white
                    ),
                    height: 50,
                    width: itemWidth,
                    child: textViewCenter(PageName.ok, Colors.black, 20, FontWeight.bold),
                  ),
                  onTap: (){
                    Navigator.pop(context, "Success");
                  },
                )
              ],
            )
        )
    );
  }
}