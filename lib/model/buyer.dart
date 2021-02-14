class Buyer {
  String id;
  String firstname;
  String lastname;
  String phone;
  String password;
  Null email;
  String roleId;
  String address1;
  String address2;
  String city;
  String state;
  Null lattitude;
  Null longitude;
  String zoneId;
  String isActive;
  String isDeleted;
  String createdAt;
  String updatedAt;
  String referralCode;
  String referralPoints;
  String token;
  String totalAmount;
  String dueAmount;
  String zoneTitle;

  Buyer(
      {this.id,
        this.firstname,
        this.lastname,
        this.phone,
        this.password,
        this.email,
        this.roleId,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.lattitude,
        this.longitude,
        this.zoneId,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.referralCode,
        this.referralPoints,
        this.token,
        this.totalAmount,
        this.dueAmount,
        this.zoneTitle});

  Buyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
    roleId = json['role_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    zoneId = json['zone_id'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    referralCode = json['referral_code'];
    referralPoints = json['referral_points'];
    token = json['token'];
    totalAmount = json['total_amount'];
    dueAmount = json['due_amount'];
    zoneTitle = json['zone_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['email'] = this.email;
    data['role_id'] = this.roleId;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['zone_id'] = this.zoneId;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['referral_code'] = this.referralCode;
    data['referral_points'] = this.referralPoints;
    data['token'] = this.token;
    data['total_amount'] = this.totalAmount;
    data['due_amount'] = this.dueAmount;
    data['zone_title'] = this.zoneTitle;
    return data;
  }
}