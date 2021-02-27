import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/color_page.dart';

class BannerPage extends StatefulWidget {
  BannerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeight = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(itemWidth * 0.02),
      color: BLACK,
      height: itemHeight * 0.5,
      width: itemWidth,
    );
  }
}