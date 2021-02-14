import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:water_supply_app/api_service/api.dart';
import 'package:water_supply_app/model/base_model.dart';
import 'package:water_supply_app/model/enquiry.dart';


class EnquiryRepo {

  static void fetchData({
    @required String fullName,
    @required String phone,
    @required String address,
    @required String city,
    @required String referralCode,
    @required ValueChanged<BaseModel> onSuccess,
    @required ValueChanged<String> onError,
  }) async {
    var body = {
      "fullname":fullName,
      "phone":phone,
      "address":address,
      "city":city,
      "referral_code":referralCode
    };
    Api().postCall(
        url: 'enquiry',
        body: body,
        onSuccess: (success) {
          var data = success['data'];
          if (data != null || data != "") {
            onSuccess(BaseModel.fromJson(success, Enquiry.fromJson(data)));
          }else{
            onSuccess(BaseModel.fromJson(success, {}));
          }
        },
        onError: (error) => onError(error)
    );
  }
}
