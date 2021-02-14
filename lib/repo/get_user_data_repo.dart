
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/user.dart';

class GetUserDataRepo {

  GetUserDataRepo._();

  static void fetchData({
    @required String token,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    Api().getCall(
        url: 'getUserData',
        token: token,
        onSuccess: (success) {
          var data = success['data'];
          if (data != null && data != "") {
            var user = data['user'];
            onSuccess(BaseModel.fromJson(success, User.fromJson(user)));
          }else{
            onSuccess(BaseModel.fromJson(success, {}));
          }
        },
        onError: (error) => onError(error)
    );
  }
}
