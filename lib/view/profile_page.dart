import 'package:flutter/material.dart';
import 'package:flutter_project/presenter/app_bar_presenter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_project/view/app_bar_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> implements AppbarContract {

  AppbarPresenter appbarPresenter;
  double heightAppbar = 0.0;

  @override
  void initState() {
    appbarPresenter = new AppbarPresenter(this);
    loadHeightAppbar();
    super.initState();
  }

  void loadHeightAppbar(){
    if (kIsWeb) {
      heightAppbar = 60.0;
    } else {
      heightAppbar = 85.0;
    }
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBarCart(appbarPresenter: appbarPresenter, heightAppbar: heightAppbar),
      body: Container(
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
      ),
    );
  }

  @override
  void goToCartPage() {

  }

  @override
  void showDialogLogin(String message) {

  }

  @override
  void showMessageError(String message, BuildContext buildContext) {

  }
}