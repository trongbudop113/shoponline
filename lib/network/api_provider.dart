import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_project/common/common.dart';
import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class ApiProvider {
  final String _baseUrl = Common.BASE_URL;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var link = _baseUrl + url;
      print("call API $link");
      final response = await http.get(link);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<List<dynamic>> fetchDataList(String uri, dynamic data) async{
    http.Response response;
    var responseJson;
    var body = json.encode(data.toMap());
    var link = _baseUrl+uri;
    try {

      print("call API $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<List<dynamic>> fetchDataListNoMapData(String uri) async{
    http.Response response;
    var responseJson;
    Map data = {};
    var body = json.encode(data);
    var link = _baseUrl+uri;
    try {
      print("call API $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fetchAllDataObject(String uri, dynamic data) async{
    http.Response response;
    var responseJson;
    var body = json.encode(data.toMap());
    var link = _baseUrl+uri;
    try {
      print("call API $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fetchAllDataObjectMap(String uri, Map data) async{
    http.Response response;
    var responseJson;
    var body = json.encode(data);
    var link = _baseUrl+uri;
    try {
      print("call API $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> fetchAllDataObjectNoMap(String uri) async{
    http.Response response;
    var responseJson;
    Map data = {};
    var body = json.encode(data);
    var link = _baseUrl+uri;
    try {
      print("call API $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> headlineHandleItem(String uri, dynamic data) async{
    http.Response response;
    var responseJson;
    var body = json.encode(data.toMap());
    var link = _baseUrl+uri;
    try {
      print("call API: $link $body");
      response = await http.post(link, headers: {"Content-Type": "application/json"}, body: body);
      print("API response: $link $body ${response.body}");
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}