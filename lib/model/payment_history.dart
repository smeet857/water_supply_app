class PaymentHistory {
  String id;
  String buyerId;
  String paymentMode;
  String paymentReceivedBy;
  String paymentReceived;
  String paymentDue;
  String notes;
  String createdAt;
  String paymentReceiverName;
  String paymentReceiverPhone;
  String paymentReceiverRole;

  PaymentHistory(
      {this.id,
        this.buyerId,
        this.paymentMode,
        this.paymentReceivedBy,
        this.paymentReceived,
        this.paymentDue,
        this.notes,
        this.createdAt,
        this.paymentReceiverName,
        this.paymentReceiverPhone,
        this.paymentReceiverRole});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buyerId = json['buyer_id'];
    paymentMode = json['payment_mode'];
    paymentReceivedBy = json['payment_received_by'];
    paymentReceived = json['payment_received'];
    paymentDue = json['payment_due'];
    notes = json['notes'];
    createdAt = json['created_at'];
    paymentReceiverName = json['payment_receiver_name'];
    paymentReceiverPhone = json['payment_receiver_phone'];
    paymentReceiverRole = json['payment_receiver_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['buyer_id'] = this.buyerId;
    data['payment_mode'] = this.paymentMode;
    data['payment_received_by'] = this.paymentReceivedBy;
    data['payment_received'] = this.paymentReceived;
    data['payment_due'] = this.paymentDue;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['payment_receiver_name'] = this.paymentReceiverName;
    data['payment_receiver_phone'] = this.paymentReceiverPhone;
    data['payment_receiver_role'] = this.paymentReceiverRole;
    return data;
  }
}
