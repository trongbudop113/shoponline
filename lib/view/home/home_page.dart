import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_project/api/menu_left_api.dart';
import 'package:flutter_project/common/common.dart';
import 'package:flutter_project/common/database_collection.dart';
import 'package:flutter_project/dialog/progress_dialog.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/menu_left_notifier.dart';
import 'package:flutter_project/presenter/home/home_presenter.dart';
import 'package:flutter_project/values/color_page.dart';
import 'package:flutter_project/view/cart_page.dart';
import 'package:flutter_project/view/chat/list_chat_page.dart';
import 'package:flutter_project/view/detail_item_shop_page.dart';
import 'package:flutter_project/view/favorite_page.dart';
import 'package:flutter_project/view/home/banner_page.dart';
import 'package:flutter_project/view/home/body_right_home.dart';
import 'package:flutter_project/view/home/footer_page.dart';
import 'package:flutter_project/view/home/header_page.dart';
import 'package:flutter_project/view/login_page.dart';
import 'package:flutter_project/view/profile_page.dart';
import 'package:flutter_project/widget/dialog_widget.dart';
import 'package:flutter_project/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeContract {

  HomePresenter homePresenter;
  var itemPos = 0;
  bool _isShow = false;
  String categoryName;
  double heightAppbar = 0.0;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  //final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    loadHeightAppbar();
    MenuLeftNotifier menuLeftNotifier = Provider.of<MenuLeftNotifier>(context, listen: false);
    getCategoryData(menuLeftNotifier);
    homePresenter = new HomePresenter(this);
    super.initState();
  }

  void loadHeightAppbar(){
    if (kIsWeb) {
      heightAppbar = 60.0;
    } else {
      heightAppbar = 85.0;
    }
  }

  void registerNotification(String uid) {
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
      Platform.isAndroid ? showNotification(message['notification']) : showNotification(message['aps']['alert']);
      return;
    },
    onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      return;
    },
    onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      return;
    }, onBackgroundMessage: myBackgroundMessageHandler
    );

    firebaseMessaging.getToken().then((token) {
      print('token: $token');
      Firestore.instance.collection(DatabaseCollection.ALL_USER).doc(uid).update({'pushToken': token});
    }).catchError((err) {
      Toast.show("$err", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
    });
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("myBackgroundMessageHandler data: $data");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("myBackgroundMessageHandler notification: $notification");
    }

    // Or do other work.
  }

  // void configLocalNotification() {
  //   var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
  //   var initializationSettingsIOS = new IOSInitializationSettings();
  //   var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.verz.shop' : 'com.verz.shop',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);

    // await flutterLocalNotificationsPlugin.show(
    //     0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
    //     payload: json.encode(message));
  }

  @override
  Widget build(BuildContext context) {

    var itemWidth = MediaQuery.of(context).size.width;
    var itemHeight = MediaQuery.of(context).size.height;
    var itemWidthCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    var itemHeightCustom = !Common.isPortrait(context) ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

    var widthLeft = ((itemWidth - ((itemWidth * 0.08))) * 0.13) > 70.0 ? ((itemWidth - (2 * (itemWidth * 0.08))) * 0.13) : 70.0;

    MenuLeftNotifier menuLeftNotifier = Provider.of<MenuLeftNotifier>(context);
    BodyRightNotifier bodyRightNotifier = Provider.of<BodyRightNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(homePresenter: homePresenter, heightAppbar: heightAppbar),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BannerPage(),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(itemWidthCustom * 0.02),
              height: itemHeightCustom,
              width: itemWidth,
              child: Row(
                children: [
                  Container(
                      width: widthLeft,
                      child: ListView.builder(
                        itemCount: menuLeftNotifier.categoryList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              hoverColor: Colors.white,
                              onTap: (){
                                menuLeftNotifier.currentCategory = menuLeftNotifier.categoryList[index];
                                menuLeftNotifier.currentIndex = index;
                                getProductsData(bodyRightNotifier, menuLeftNotifier.currentCategory);
                              },
                              child: Container(
                                height: 70,
                                color: menuLeftNotifier.currentIndex == index ? WHITE : BLACK,
                                padding: EdgeInsets.all(12),
                                child: !Common.isPortrait(context) ?
                                Row(
                                  children: [
                                    textView(menuLeftNotifier.categoryList[index].name.toUpperCase(), menuLeftNotifier.currentIndex == index ? BLACK : WHITE, itemWidth * 0.01, FontWeight.bold),
                                    Spacer(flex: 1,),
                                    Icon(Icons.home, color: menuLeftNotifier.currentIndex == index ? BLACK : WHITE)
                                  ],
                                ) :
                                Column(
                                  children: [
                                    Icon(Icons.home, color: menuLeftNotifier.currentIndex == index ? BLACK : WHITE),
                                    textView(menuLeftNotifier.categoryList[index].name.toUpperCase(), menuLeftNotifier.currentIndex == index ? BLACK : WHITE, 6, FontWeight.bold),
                                  ],
                                ),
                              )
                          );
                        },
                      )
                  ),
                  Container(
                      width: (itemWidth - ((itemWidth * 0.08))) - (widthLeft + 5),
                      padding: EdgeInsets.only(left: itemWidth * 0.01),
                      child: Stack(
                        children: [
                          menuLeftNotifier.currentIndex == 0 ?
                          ContainBodyHome(

                          ) :
                          ContainBodyRight(
                            width: itemWidth,
                            height: itemHeightCustom,
                            homePresenter: homePresenter,
                            menuLeft: menuLeftNotifier.currentCategory,
                          ),
                          _isShow ? Center(
                            child: IndicatorProgress(),
                          ) : Container()
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FooterPage(homePresenter: homePresenter),
          )
        ],
      ),
    );
  }

  @override
  void goToCartDetail() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CartPage()
    ));
  }

  @override
  void goToWishList() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => FavoritePage()
    ));
  }

  @override
  Future<void> goToLogin() async {
    var a = await Navigator.push(context, MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
    if(a.toString() != null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString(Common.UUID) ?? '';
      registerNotification(uid);
      //configLocalNotification();
    }
  }

  @override
  Future<void> showMessageError(String message, BuildContext buildContext) async {
    await showDialog(
      context: buildContext,
      builder: (_) => ShowLoginDialog(title: "Login....", msg: message),
    );
  }

  @override
  void goToPerson() {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ProfilePage()
    ));
  }

  @override
  void goToDetail() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return ItemDetailPage();
    }));
  }

  @override
  void showToastMessage(String message) {

  }

  @override
  void goToChat(String uuid) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ListChatScreen(currentUserId: uuid)));
  }
}