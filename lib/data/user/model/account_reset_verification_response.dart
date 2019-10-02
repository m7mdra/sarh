/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

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
  String phone;
  String activationCode;

  Data(
      {this.id,
        this.token,
        this.phone,
        this.activationCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    phone = json['phone'];
    activationCode = json['activation_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['phone'] = this.phone;
    data['activation_code'] = this.activationCode;
    return data;
  }
}
