
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_supply_app/util/my_colors.dart';

Widget loader() => Scaffold(
  body: Center(
    child: CircularProgressIndicator(),
  ),
);

Widget errorView({Function callBack}){
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error,color: Mycolor.accent,size: 80,),
          SizedBox(height: 10,),
          Text("Something Went Wrong",style: TextStyle(color: Mycolor.accent,fontWeight: FontWeight.w500,fontSize: 20),),
          SizedBox(height: 10,),
          FlatButton(onPressed: callBack, color:Mycolor.accent,child: Text("Retry",style: TextStyle(color: Colors.white),))
        ],
      ),
    ),
  );
}