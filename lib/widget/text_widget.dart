import 'package:flutter/cupertino.dart';

Widget textView(String text, Color color, double size, FontWeight fontWeight){
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight
    ),
  );
}