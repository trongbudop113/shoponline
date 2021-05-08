import 'package:flutter/cupertino.dart';

class Common {
  //screen
  static const String REGISTER_SCREEN = "/register";
  static const String LOGIN_SCREEN = "/login";

  //STATIC WEB URL
  static const String BASE_URL = "https://web_api";

  static const String LOGIN = "LOGIN";
  static const String UUID = "UUID";

  static List<String> getListSort(){
    var listSort = ['Sort', 'Product Type', 'Style', 'Size', 'Colors'];
    return listSort;
  }

  static bool isPortrait(BuildContext context){
    Orientation orientation = MediaQuery.of(context).orientation;
    if(orientation == Orientation.portrait){
      return true;
    }else{
      return false;
    }
  }
}