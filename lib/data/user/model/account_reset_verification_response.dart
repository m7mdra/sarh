class AccountResetVerificationResponse {
  bool success;
  Data data;
  String message;

  AccountResetVerificationResponse({this.success, this.data, this.message});

  AccountResetVerificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String token;
  String createdAt;
  String updatedAt;
  String phone;
  String activationCode;
  String email;
  Null deletedAt;

  Data(
      {this.id,
        this.token,
        this.createdAt,
        this.updatedAt,
        this.phone,
        this.activationCode,
        this.email,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    activationCode = json['activation_code'];
    email = json['email'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['phone'] = this.phone;
    data['activation_code'] = this.activationCode;
    data['email'] = this.email;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
