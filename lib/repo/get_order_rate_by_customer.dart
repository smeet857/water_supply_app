
import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/content.dart';
import 'package:water_supply_app/model/orders.dart';


class GetOrderRateByCustomerRepo {

  static void fetchData({
    @required String userId,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      'user_id':userId
};
    Api().postCall(
        url: 'getOrderRateByCustomer',
        body: body,
        onSuccess: (success) {
          var data = success['orders'];
          if (data != null || data != "") {
            List<Orders> list = [];
            data.forEach((element){
              list.add(Orders.fromJson(element));
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
