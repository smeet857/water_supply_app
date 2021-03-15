import 'package:flutter/material.dart';
import 'package:water_supply_app/model/orders_delivery.dart';
import 'package:water_supply_app/util/my_colors.dart';

class OrderDetailsPage extends StatelessWidget {

  final OrderDelivery orderDelivery;

  const OrderDetailsPage({Key key, this.orderDelivery}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        titleSpacing: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 30),
        child: Column(
          children: [
            commonTile("Order id", orderDelivery.orderId),
            SizedBox(
              height: 30,
            ),
            commonTile("Service", orderDelivery.serviceName),
            SizedBox(
              height: 30,
            ),
            commonTile("TotalAmount", orderDelivery.totalAmount),
            SizedBox(
              height: 30,
            ),
            commonTile("Quantity Order", orderDelivery.qtyOrdered),
            SizedBox(
              height: 30,
            ),
            commonTile("Delivery By", orderDelivery.deliveryBoyName),
            SizedBox(
              height: 30,
            ),
            commonTile("Delivery Phone", orderDelivery.deliveryBoyPhone),
            SizedBox(
              height: 30,
            ),
            commonTile("Delivery Date", orderDelivery.deliveryDate),
          ],
        ),
      ),
    );
  }
  Widget commonTile(String title, String desc) {
    if(desc == ""){
      desc = "Empty";
    }

    return Row(
      children: [
        Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
        Expanded(
            flex: 1,
            child: Text(
              ":",
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
        Expanded(
            flex: 3,
            child: Text(
              desc,
              style: TextStyle(color: Mycolor.accent, fontSize: 18),
            )),
      ],
    );
  }
}
