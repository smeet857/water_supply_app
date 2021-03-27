class SocietyModel {
  String id;
  String name;
  String zoneId;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;
  String deletedAt;

  SocietyModel(
      {this.id,
        this.name,
        this.zoneId,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  SocietyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    zoneId = json['zone_id'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['zone_id'] = this.zoneId;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}