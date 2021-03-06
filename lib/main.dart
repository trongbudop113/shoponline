import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/notifier/auth_notifier.dart';
import 'package:flutter_project/notifier/body_right_notifier.dart';
import 'package:flutter_project/notifier/cart_notifier.dart';
import 'package:flutter_project/notifier/favorite_notifier.dart';
import 'package:flutter_project/notifier/menu_left_notifier.dart';
import 'package:flutter_project/view/home/home_page.dart';
import 'package:provider/provider.dart';

  void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
          statusBarIconBrightness: Brightness.light
      )
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MenuLeftNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => BodyRightNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => FavoriteNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
