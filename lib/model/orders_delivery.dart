class OrderDelivery {
  String orderDeliveryId;
  String orderId;
  String deliveryDate;
  String qtyOrdered;
  String totalAmount;
  String deliveryNotes;
  String deliveryBoyId;
  String deliveryBoyName;
  String deliveryBoyPhone;
  Null email;
  String zoneId;
  String zoneName;

  OrderDelivery(
      {this.orderDeliveryId,
        this.orderId,
        this.deliveryDate,
        this.qtyOrdered,
        this.totalAmount,
        this.deliveryNotes,
        this.deliveryBoyId,
        this.deliveryBoyName,
        this.deliveryBoyPhone,
        this.email,
        this.zoneId,
        this.zoneName});

  OrderDelivery.fromJson(Map<String, dynamic> json) {
    orderDeliveryId = json['order_delivery_id'];
    orderId = json['order_id'];
    deliveryDate = json['delivery_date'];
    qtyOrdered = json['qty_ordered'];
    totalAmount = json['total_amount'];
    deliveryNotes = json['delivery_notes'];
    deliveryBoyId = json['delivery_boy_id'];
    deliveryBoyName = json['delivery_boy_name'];
    deliveryBoyPhone = json['delivery_boy_phone'];
    email = json['email'];
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_delivery_id'] = this.orderDeliveryId;
    data['order_id'] = this.orderId;
    data['delivery_date'] = this.deliveryDate;
    data['qty_ordered'] = this.qtyOrdered;
    data['total_amount'] = this.totalAmount;
    data['delivery_notes'] = this.deliveryNotes;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['delivery_boy_name'] = this.deliveryBoyName;
    data['delivery_boy_phone'] = this.deliveryBoyPhone;
    data['email'] = this.email;
    data['zone_id'] = this.zoneId;
    data['zone_name'] = this.zoneName;
    return data;
  }
}
