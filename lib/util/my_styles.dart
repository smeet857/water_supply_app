import 'package:flutter/material.dart';
import 'package:water_supply_app/util/my_colors.dart';
class MyStyle{
  static AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.white,
    textTheme: TextTheme(title:TextStyle(color: Mycolor.accent,fontSize: 25,fontWeight: FontWeight.bold)),
    elevation: 0,
    iconTheme: IconThemeData(
      color: Mycolor.accent
    )
  );
}