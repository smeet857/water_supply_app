class BaseModel<T> {
  int flag;
  String message;
  String token;
  String totalAmount;
  String dueAmount;
  int status;
  T data;

  BaseModel(
      {this.flag,
        this.message,
        this.token,
        this.status,
        this.totalAmount,
        this.dueAmount,
        this.data});

  BaseModel.fromJson(Map<String, dynamic> json, T t) {
    flag = json["flag"];
    message = json["message"];
    status = json["status"];
    token = json["token"];
    totalAmount = json["total_amount"];
    dueAmount = json["due_amount"];
    data = t;
  }
}
