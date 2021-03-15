import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/user.dart';
import 'package:water_supply_app/util/constants.dart';


class UpdateUserDueAmountRepo {

  static void fetchData({
    @required String buyerId,
    @required String payAmount,
    @required String paymentMode,
    @required String paymentNote,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      "data":[
        {
          "buyer_id":buyerId,
          "pay_amount":payAmount,
          "payment_mode":paymentMode,
          "payment_notes":paymentNote
        }
      ]
    };
    Api().postCall(
      url: 'updateUserTotalDueAmount',
      body: body,
      token: user.token,
      onSuccess: (success) {
        var data = success['data'];
        if (data != null || data != "") {
          List<User> list = [];
          data.forEach((element){
            list.add(new User.fromJson(element));
          });
          onSuccess(BaseModel.fromJson(success, list));
        }else{
          onSuccess(BaseModel.fromJson(success, data));
        }
      },
      onError: (error) => onError(error),
    );
  }
}
