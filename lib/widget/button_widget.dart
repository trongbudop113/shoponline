import 'package:flutter/cupertino.dart';

Widget borderButton(String url, double radius, double width, double height, Color color){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color
    ),
  );
}

Widget borderButtonGradient(String url, double radius, double width, double height, Color color1, Color color2){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2]
        ),
    ),
  );
}