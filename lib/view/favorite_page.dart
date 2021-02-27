import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      height: itemHeight * 0.35,
      width: itemWidth,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.pink[100]
            ),
            width: itemWidth * 0.7,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.greenAccent,
            ),
            width: itemWidth * 0.3,
          )
        ],
      ),
    );
  }
}