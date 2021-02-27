import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Container(
      height: itemHeight * 0.2,
      width: itemWidth,
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          Container(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView('Về chúng tôi', Colors.black, 20, FontWeight.bold),
                textView('Giới thiệu về chúng tôi', Colors.black, 14, FontWeight.normal),
                textView('Chính sách bảo mật', Colors.black, 14, FontWeight.normal),
                textView('Phương thức thanh toán', Colors.black, 14, FontWeight.normal),
                textView('Phương thức giao hàng', Colors.black, 14, FontWeight.normal)
              ],
            ),
          ),
          SizedBox(width: itemWidth * 0.02),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView('Theo dõi chúng tôi trên', Colors.black, 20, FontWeight.bold),
                Row(
                  children: [
                    Icon(Icons.face),
                    textView('Facebook', Colors.black, 14, FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.camera_alt),
                    textView('Instagram', Colors.black, 14, FontWeight.normal)
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: itemWidth * 0.02),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView('Liên hệ', Colors.black, 20, FontWeight.bold),
                Row(
                  children: [
                    Icon(Icons.phone_android),
                    textView('Gọi cho tôi', Colors.black, 14, FontWeight.normal),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.chat),
                    textView('Chat với chúng tôi', Colors.black, 14, FontWeight.normal)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}