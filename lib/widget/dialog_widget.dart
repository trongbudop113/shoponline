import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowLoginDialog extends StatefulWidget {

  String msg;
  String title;

  ShowLoginDialog({this.title, this.msg});

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<ShowLoginDialog> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width * 0.35;
    final double itemHeight = size.height * 0.3;

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: itemWidth,
            height: itemHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 1,),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    widget.msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Spacer(flex: 1,),
                Row(children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        height: 45,
                        width: itemWidth / 2,
                        child: Text(
                          'CANCEL',
                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        height: 45,
                        width: itemWidth / 2,
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],)
              ],
            )
        )
    );
  }
}