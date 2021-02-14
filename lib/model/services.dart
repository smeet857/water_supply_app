import 'measure.dart';

class Services {
  String id;
  String title;
  String qty;
  String measureId;
  String price;
  String notes;
  String isActive;
  String isDeleted;
  String serviceImg;
  String createdAt;
  String updatedAt;
  String measureName;
  Measure measure;

  Services(
      {this.id,
        this.title,
        this.qty,
        this.measureId,
        this.price,
        this.notes,
        this.isActive,
        this.isDeleted,
        this.serviceImg,
        this.createdAt,
        this.updatedAt,
        this.measureName,
        this.measure});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    qty = json['qty'];
    measureId = json['measure_id'];
    price = json['price'];
    notes = json['notes'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    serviceImg = json['service_img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    measureName = json['measure_name'];
    measure =
    json['measure'] != null ? new Measure.fromJson(json['measure']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['qty'] = this.qty;
    data['measure_id'] = this.measureId;
    data['price'] = this.price;
    data['notes'] = this.notes;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['service_img'] = this.serviceImg;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['measure_name'] = this.measureName;
    if (this.measure != null) {
      data['measure'] = this.measure.toJson();
    }
    return data;
  }
}