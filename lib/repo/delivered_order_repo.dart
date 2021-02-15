import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/util/constants.dart';


class DeliveredOrderRepo {

  static void fetchData({
    @required String buyerId,
    @required String qtyOrdered,
    @required String totalAmount,
    @required String orderId,
    @required String deliveryNotes,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      "data":[
        {
          "buyer_id":buyerId,
          "delivery_date":DateFormat("yyyy-MM-dd").format(DateTime.now()),
          "qty_ordered":orderId,
          "total_amount":totalAmount,
          "order_id":orderId,
          "delivery_notes":deliveryNotes
        }
      ]
    };
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
