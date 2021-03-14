import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textView(String text, Color color, double size, FontWeight fontWeight){
  return Text(
    text,
    style: GoogleFonts.bungee(
      textStyle: TextStyle(
        color: color
      ),
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Widget textViewCenter(String text, Color color, double size, FontWeight fontWeight){
  return Text(
    text,
    textAlign: TextAlign.center,
    style: GoogleFonts.bungee(
      textStyle: TextStyle(
          color: color,
      ),
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Widget textViewLine(String text, Color color, double size, FontWeight fontWeight, double line){
  return Text(
    text,
    style: GoogleFonts.bungee(
      textStyle: TextStyle(
          color: color
      ),
      fontSize: size,
      fontWeight: fontWeight,
      height: line
    ),
  );
}