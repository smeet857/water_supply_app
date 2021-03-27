
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/society_model.dart';


class GetSocietyByZoneIdRepo {

  static void fetchData({
    @required String zoneId,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      'zone_id':zoneId
    };
    Api().postCall(
        url: 'getSocietyByZone',
        body: body,
        onSuccess: (success) {
          var data = success['society'];
          if (data != null || data != "") {
            List<SocietyModel> list = [];
            data.forEach((element){
              list.add(SocietyModel.fromJson(element));
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
