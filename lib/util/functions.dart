
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:water_supply_app/dialog/progress_dialog.dart';
import 'package:water_supply_app/model/user.dart';

import 'constants.dart';
import 'my_shared_preference.dart';

void showProgress(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ProgressDialog()
  );
}

void toast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void errorToast(String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Future<void> saveUser(User userObject) async {
  final str = jsonEncode(userObject.toJson());
  await SaveValue.string(Keys.user, str);
  user = userObject;
}

Future<void> getUser() async {
  String str = await GetValue.string(Keys.user);
  if(str == null){
    user = null;
    return;
  }
  user = User.fromJson(jsonDecode(str));
}
String formatDate(String strDate , String format){
  var date = DateTime.parse(strDate);
  var formatter = DateFormat(format);
  return formatter.format(date);
}