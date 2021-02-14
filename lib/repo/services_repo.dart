import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/services.dart';



class ServicesRepo {

  ServicesRepo._();

  static void fetchData({
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    Api().getCall(
        url: 'services',
        onSuccess: (success) {
          var data = success['services'];
          if (data != null || data != "") {
            List<Services> list = [];
            data.forEach((element){
              list.add(new Services.fromJson(element));
            });
            onSuccess(BaseModel.fromJson(success, list));
          }else{
            onSuccess(BaseModel.fromJson(success, {}));
          }
        },
        onError: (error) => onError(error)
    );
  }
}
