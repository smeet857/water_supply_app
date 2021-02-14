import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/payment_history.dart';

class UserPaymentHistoryRepo {
  UserPaymentHistoryRepo._();

  static void fetchData({
    @required String buyerId,
    @required String token,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    Api().postCall(
      url: 'userPaymentHistory',
      body: {"buyer_id": buyerId},
      token: token,
      onSuccess: (success) {
        var data = success['data'];
        if (data != null && data != "") {
          List<PaymentHistory> list = [];
          data.forEach((element){
            list.add(PaymentHistory.fromJson(element));
          });
          onSuccess(BaseModel.fromJson(success, list));
        } else {
          onSuccess(BaseModel.fromJson(success, {}));
        }
      },
      onError: (error) => onError(error),
    );
  }
}
