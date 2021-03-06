import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterPage extends StatefulWidget {
  FooterPage({Key key, this.homePresenter}) : super(key: key);
  final HomePresenter homePresenter;

  @override
  _FooterPageState createState() => _FooterPageState();
}

class _FooterPageState extends State<FooterPage> {

  double spaceInt = 0.005;

  @override
  Widget build(BuildContext context) {

    var itemWidth = !Common.isPortrait(context)? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeight = !Common.isPortrait(context)? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    var textSize20 = !Common.isPortrait(context)? itemWidth * 0.015 : 20.0;

    Widget fromUs(){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: textView('Về chúng tôi', WHITE, textSize20, FontWeight.bold),
            ),
            SizedBox(height: itemHeight * 0.01),
            Container(
              margin: EdgeInsets.only(left: itemWidth * 0.01),
              child: textView('Giới thiệu về chúng tôi', WHITE, itemWidth * 0.01, FontWeight.normal),
            ),
            SizedBox(height: itemHeight * spaceInt),
            Container(
              margin: EdgeInsets.only(left: itemWidth * 0.01),
              child: textView('Chính sách bảo mật', WHITE, itemWidth * 0.01, FontWeight.normal),
            ),
            SizedBox(height: itemHeight * spaceInt),
            Container(
              margin: EdgeInsets.only(left: itemWidth * 0.01),
              child: textView('Phương thức thanh toán', WHITE, itemWidth * 0.01, FontWeight.normal),
            ),
            SizedBox(height: itemHeight * spaceInt),
            Container(
              margin: EdgeInsets.only(left: itemWidth * 0.01),
              child: textView('Phương thức giao hàng', WHITE, itemWidth * 0.01, FontWeight.normal),
            ),
            SizedBox(height: itemHeight * spaceInt),
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
            SizedBox(height: itemHeight * 0.01),
            InkWell(
              child: Row(
                children: [
                  SizedBox(width: itemWidth * 0.01),
                  Icon(Icons.face, size: itemWidth * 0.011, color: WHITE),
                  SizedBox(width: itemWidth * 0.005),
                  textView('Facebook', WHITE, itemWidth * 0.01, FontWeight.normal),
                ],
              ),
              onTap: (){
                _launchInWebViewWithJavaScript('https://www.facebook.com/trong.luuhoang/');
              },
            ),
            SizedBox(height: itemHeight * spaceInt),
            InkWell(
              child: Row(
                children: [
                  SizedBox(width: itemWidth * 0.01),
                  Icon(Icons.camera_alt, size: itemWidth * 0.011, color: WHITE),
                  SizedBox(width: itemWidth * 0.005),
                  textView('Instagram', WHITE, itemWidth * 0.01, FontWeight.normal)
                ],
              ),
              onTap: (){
                _launchInWebViewWithJavaScript('https://www.instagram.com/luu_hoang_trong/');
              },
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
            SizedBox(height: itemHeight * 0.01),
            InkWell(
              child: Row(
                children: [
                  SizedBox(width: itemWidth * 0.01),
                  Icon(Icons.phone_android, size: itemWidth * 0.011, color: WHITE),
                  SizedBox(width: itemWidth * 0.005),
                  textView('Gọi cho tôi', WHITE, itemWidth * 0.01, FontWeight.normal),
                ],
              ),
              onTap: (){
                launch("tel://0356882046");
              },
            ),
            SizedBox(height: itemHeight * spaceInt),
            InkWell(
              child: Row(
                children: [
                  SizedBox(width: itemWidth * 0.01),
                  Icon(Icons.chat, size: itemWidth * 0.011, color: WHITE),
                  SizedBox(width: itemWidth * 0.005),
                  textView('Chat với chúng tôi', WHITE, itemWidth * 0.01, FontWeight.normal)
                ],
              ),
              onTap: () {
                widget.homePresenter.goToChatPage(context);
              },
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

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}