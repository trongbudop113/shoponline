import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerPage extends StatefulWidget {
  BannerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      height: itemHeight * 0.35,
      width: itemWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.pink[100]
      ),
    );
  }
}