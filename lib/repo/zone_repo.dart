
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/user.dart';
import 'package:water_supply_app/model/zone_details.dart';

class GetZoneRepo {

  GetZoneRepo._();

  static void fetchData({
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    Api().getCall(
        url: 'zones',
        onSuccess: (success) {
          var data = success['zones'];
          if (data != null || data != "") {
            List<ZoneDetails> list = [];
            data.forEach((element){
              list.add(new ZoneDetails.fromJson(element));
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
