
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/content.dart';


class ContentRepo {

  ContentRepo._();

  static void fetchData({
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    Api().getCall(
        url: 'contents',
        onSuccess: (success) {
          var data = success['content'];
          if (data != null || data != "") {
            List<Content> list = [];
            data.forEach((element){
              list.add(new Content.fromJson(element));
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
