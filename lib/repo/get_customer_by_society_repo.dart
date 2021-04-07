
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/user.dart';

class GetCustomerBySocietyRepo {

  GetCustomerBySocietyRepo._();

  static void fetchData({
    @required String society_id,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var _body = {
      "society_id":society_id
    };

    Api().postCall(
        url: 'getCustomersBySociety',
        token: token,
        body: _body,
        onSuccess: (success) {
          var data = success['customers'];
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
        onError: (error) => onError(error)
    );
  }
}
