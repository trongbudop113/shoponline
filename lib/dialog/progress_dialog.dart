import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IndicatorProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: BLACK,
      padding: EdgeInsets.all(10),
      width: 100,
      height: 100,
      child: SpinKitFadingCube(color: WHITE)
    );
  }

}