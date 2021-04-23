import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class Api {
  String baseUrl = "http://admin.jeelaqua.in/api/users/";

  void getCall({
    @required String url,
    String token,
    Map<String, dynamic> body,
    @required ValueChanged<dynamic> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    try {
      final response = await get(
        baseUrl + url,
        headers: token == null
            ? {"Accept": "application/json", "Content-Type": "application/json"}
            : {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "token": token
              },
      );
      switch (response.statusCode) {
        case 200:
          print("responce === > ${response.body}");
          return onSuccess(jsonDecode(response.body));
        case 500:
          return onError(
              'error 500 ===> Server Error : ${response.body.toString()}');
        case 400:
          return onError(
              'error 400 ===> BadRequestException : ${response.body.toString()}');
        case 403:
          return onError(
              'error 403 ===> UnauthorizedException : ${response.body.toString()}');
        case 401:
        case 404:
          return onSuccess(jsonDecode(response.body));
        default:
          return onError(response.body.toString());
      }
    } on Exception catch (e) {
      onError('error on api code FetchDataException ${e.toString()}');
    }
  }

  void postCall(
      { String url,
      @required Map<String, dynamic> body,
      String token,
      @required ValueChanged<dynamic> onSuccess,
      @required ValueChanged<String> onError}) async {
    try {
      var response = await post(
        baseUrl + url,
        body: json.encode(body),
        headers: token != null
            ? {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "token": token,
              }
            : {
                "Accept": "application/json",
                "Content-Type": "application/json",
              },
      );
      switch (response.statusCode) {
        case 200:
          print("responce === > ${response.body}");
          return onSuccess(jsonDecode(response.body));
        case 500:
          return onError(
              'error 500 ===> Server Error : ${response.body.toString()}');
        case 400:
          return onError(
              'error 400 ===> BadRequestException : ${response.body.toString()}');
        case 403:
          return onError(
              'error 403 ===> UnauthorizedException : ${response.body.toString()}');
        case 401:
        case 404:
          return onSuccess(jsonDecode(response.body));
        default:
          return onError(response.body.toString());
      }
    } on Exception catch (e) {
      onError('error on api code FetchDataException ${e.toString()}');
    }
  }
}
