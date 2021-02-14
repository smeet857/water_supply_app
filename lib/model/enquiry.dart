class Enquiry {
  String fullname;
  String phone;
  String referralCode;
  String address;
  String city;
  String createdAt;

  Enquiry(
      {this.fullname,
        this.phone,
        this.referralCode,
        this.address,
        this.city,
        this.createdAt});

  Enquiry.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    phone = json['phone'];
    referralCode = json['referral_code'];
    address = json['address'];
    city = json['city'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['referral_code'] = this.referralCode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['created_at'] = this.createdAt;
    return data;
  }
}