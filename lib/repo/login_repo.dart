import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/user.dart';


class LoginRepo {

  static void fetchData({
    @required String phone,
    @required String password,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      "phone":phone,
      "password":password
    };
    Api().postCall(
        url: 'login',
        body: body,
        onSuccess: (success) {
          var data = success['data'];
          if (data != null && data != "") {
            onSuccess(BaseModel.fromJson(success, User.fromJson(data)));
          }else{
            onSuccess(BaseModel.fromJson(success, {}));
          }
        },
        onError: (error) => onError(error)
    );
  }
}
