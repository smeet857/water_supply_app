import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/util/constants.dart';


class DeliveredOrderRepo {

  static void fetchData({
    @required Map<String,dynamic> data,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      "data":[
        data
      ]
    };
    print("token ====> ${user.token}");
    Api().postCall(
        url: 'deliveredOrder',
        body: body,
        token: user.token,
        onSuccess: (success) {
          onSuccess(BaseModel.fromJson(success, {}));
        },
        onError: (error) => onError(error),
    );
  }
}
