class ZoneDetails {
  String id;
  String title;
  String fromArea;
  String toArea;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;

  ZoneDetails(
      {this.id,
        this.title,
        this.fromArea,
        this.toArea,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  ZoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fromArea = json['from_area'];
    toArea = json['to_area'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['from_area'] = this.fromArea;
    data['to_area'] = this.toArea;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}