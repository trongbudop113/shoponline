import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/view/banner_page.dart';
import 'package:flutter_project/view/body_page.dart';
import 'package:flutter_project/view/footer_page.dart';
import 'package:flutter_project/view/header_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(height: itemHeight * 0.05, width: itemWidth * 0.08),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: itemWidth * 0.08),
            child: Column(
              children: [
                SizedBox(height: 20,),
                BannerPage(),
                SizedBox(height: 30,),
                BodyPage(),
                SizedBox(height: 20,),
                FooterPage(),
                SizedBox(height: 20,)
              ],
            ),
          ),
        )
    );
  }
}

class CustomAppBar extends PreferredSize {
  final double height;
  final double width;

  CustomAppBar({this.height, this.width});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      margin: EdgeInsets.symmetric(horizontal: width),
      child: HeaderPage(),
    );
  }
}