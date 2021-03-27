
import 'buyer.dart';
import 'orders_delivery.dart';
import 'payment_history.dart';
import 'services.dart';
import 'zone_details.dart';

class Orders {
  String id;
  String serviceId;
  String userId;
  String quantity;
  String price;
  String subTotal;
  String discount;
  String grandTotal;
  String createdAt;
  String notes;
  String title;
  List<OrderDelivery> orderDelivery;
  Services service;
  Buyer buyer;
  ZoneDetails zoneDetails;
  String orderId;

  Orders(
      {this.id,
        this.serviceId,
        this.userId,
        this.quantity,
        this.price,
        this.subTotal,
        this.discount,
        this.grandTotal,
        this.createdAt,
        this.notes,
        this.title,
        this.orderDelivery,
        this.service,
        this.buyer,
        this.orderId,
        this.zoneDetails});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    quantity = json['quantity'];
    price = json['price'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    title = json['title'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    orderId = json['order_id'];
    notes = json['notes'];
    if (json['order_delivery'] != null) {
      orderDelivery = new List<OrderDelivery>();
      json['order_delivery'].forEach((v) {
        orderDelivery.add(new OrderDelivery.fromJson(v));
      });
    }
    service =
    json['service'] != null ? new Services.fromJson(json['service']) : null;
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    zoneDetails = json['zone_details'] != null
        ? new ZoneDetails.fromJson(json['zone_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['title'] = this.title;
    data['sub_total'] = this.subTotal;
    data['discount'] = this.discount;
    data['order_id'] = this.orderId;
    data['grand_total'] = this.grandTotal;
    data['created_at'] = this.createdAt;
    data['notes'] = this.notes;
    if (this.orderDelivery != null) {
      data['order_delivery'] =
          this.orderDelivery.map((v) => v.toJson()).toList();
    }
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.buyer != null) {
      data['buyer'] = this.buyer.toJson();
    }
    if (this.zoneDetails != null) {
      data['zone_details'] = this.zoneDetails.toJson();
    }
    return data;
  }
}