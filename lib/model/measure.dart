class Measure {
  String id;
  String title;
  Null notes;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;

  Measure(
      {this.id,
        this.title,
        this.notes,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Measure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notes = json['notes'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notes'] = this.notes;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}