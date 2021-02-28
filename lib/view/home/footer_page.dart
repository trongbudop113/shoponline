import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';

class FooterPage extends StatefulWidget {
  FooterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FooterPageState createState() => _FooterPageState();
}

class _FooterPageState extends State<FooterPage> {

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context)? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeight = !Common.isPortrait(context)? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    var textSize20 = !Common.isPortrait(context)? itemWidth * 0.015 : 20;

    Widget fromUs(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textView('Về chúng tôi', WHITE, textSize20, FontWeight.bold),
            SizedBox(height: itemHeight * 0.02),
            textView('Giới thiệu về chúng tôi', WHITE, itemWidth * 0.01, FontWeight.normal),
            SizedBox(height: itemHeight * 0.007),
            textView('Chính sách bảo mật', WHITE, itemWidth * 0.01, FontWeight.normal),
            SizedBox(height: itemHeight * 0.007),
            textView('Phương thức thanh toán', WHITE, itemWidth * 0.01, FontWeight.normal),
            SizedBox(height: itemHeight * 0.007),
            textView('Phương thức giao hàng', WHITE, itemWidth * 0.01, FontWeight.normal),
            SizedBox(height: itemHeight * 0.007),
          ],
        ),
      );
    }

    Widget followUs(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textView('Theo dõi chúng tôi', WHITE, textSize20, FontWeight.bold),
            SizedBox(height: itemHeight * 0.02),
            Row(
              children: [
                Icon(Icons.face, size: itemWidth * 0.011, color: WHITE),
                SizedBox(width: itemWidth * 0.005),
                textView('Facebook', WHITE, itemWidth * 0.01, FontWeight.normal),
              ],
            ),
            SizedBox(height: itemHeight * 0.007),
            Row(
              children: [
                Icon(Icons.camera_alt, size: itemWidth * 0.011, color: WHITE),
                SizedBox(width: itemWidth * 0.005),
                textView('Instagram', WHITE, itemWidth * 0.01, FontWeight.normal)
              ],
            )
          ],
        ),
      );
    }

    Widget contactUs(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textView('Liên hệ', WHITE, textSize20, FontWeight.bold),
            SizedBox(height: itemHeight * 0.02),
            Row(
              children: [
                Icon(Icons.phone_android, size: itemWidth * 0.011, color: WHITE),
                SizedBox(width: itemWidth * 0.005),
                textView('Gọi cho tôi', WHITE, itemWidth * 0.01, FontWeight.normal),
              ],
            ),
            SizedBox(height: itemHeight * 0.007),
            Row(
              children: [
                Icon(Icons.chat, size: itemWidth * 0.011, color: WHITE),
                SizedBox(width: itemWidth * 0.005),
                textView('Chat với chúng tôi', WHITE, itemWidth * 0.01, FontWeight.normal)
              ],
            )
          ],
        ),
      );
    }

    return Container(
      color: BLACK,
      width: itemWidth,
      padding: EdgeInsets.all(30),
      child: !Common.isPortrait(context) ?
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fromUs(),
          SizedBox(width: itemWidth * 0.03),
          followUs(),
          SizedBox(width: itemWidth * 0.03),
          contactUs()
        ],
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fromUs(),
          SizedBox(height: itemHeight * 0.04),
          followUs(),
          SizedBox(height: itemHeight * 0.04),
          contactUs()
        ],
      )
    );
  }
}