import 'package:flutter/material.dart';
import 'package:water_supply_app/model/delivered_order.dart';
import 'package:water_supply_app/model/orders_delivery.dart';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,this.orderId);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String orderId;
}