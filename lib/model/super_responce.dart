class SuperResponce<T> {
  int flag;
  String message;
  String token;
  String totalAmount;
  String dueAmount;
  int status;
  T data;

  SuperResponce(
      {this.flag,
      this.message,
      this.token,
      this.status,
      this.totalAmount,
      this.dueAmount,
      this.data});

  SuperResponce.fromJson(Map<String, dynamic> json, T t) {
    flag = json["flag"];
    message = json["message"];
    status = json["status"];
    token = json["token"];
    totalAmount = json["total_amount"];
    dueAmount = json["due_amount"];
    data = t;
  }
}
