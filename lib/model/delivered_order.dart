class DeliveredOrder {
  List<Data> data;

  DeliveredOrder({this.data});

  DeliveredOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String buyerId;
  String deliveryDate;
  String qtyOrdered;
  String totalAmount;
  String orderId;
  String pay;
  String deliveryNotes;

  String dueAmount;

  Data(
      {this.buyerId,
        this.deliveryDate,
        this.qtyOrdered,
        this.totalAmount,
        this.orderId,
        this.pay,
        this.dueAmount,
        this.deliveryNotes});

  Data.fromJson(Map<String, dynamic> json) {
    buyerId = json['buyer_id'];
    deliveryDate = json['delivery_date'];
    qtyOrdered = json['qty_ordered'];
    totalAmount = json['total_amount'];
    orderId = json['order_id'];
    pay = json['pay'];
    deliveryNotes = json['delivery_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_id'] = this.buyerId;
    data['delivery_date'] = this.deliveryDate;
    data['qty_ordered'] = this.qtyOrdered;
    data['total_amount'] = this.totalAmount;
    data['order_id'] = this.orderId;
    data['pay'] = this.pay;
    data['delivery_notes'] = this.deliveryNotes;
    return data;
  }
}