class Content {
  String id;
  String title;
  String description;
  String type;
  String fileUpload;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;

  Content(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.fileUpload,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    fileUpload = json['file_upload'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['file_upload'] = this.fileUpload;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}