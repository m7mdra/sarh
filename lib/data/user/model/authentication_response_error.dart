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

class AuthenticationResponseError {
  String message;
  bool success;
  Data data;

  AuthenticationResponseError({this.message, this.success, this.data});

  AuthenticationResponseError.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  String get errors =>
      List.of([
        data.username.map((error) => "-  $error").join(),
        data.password.map((error) => "-  $error").join(),
        data.phone.map((error) => "- ️$error").join(),
        data.accountType.map((error) => "-️ $error").join(),
        data.city.map((error) => "- ️$error").join(),
        data.cPassword.map((error) => "- ️$error").join(),
        data.firebaseToken.map((error) => "-️ $error").join(),
      ]).join('\n').trim() ??
      ''.trim();
}

class Data {
  List<String> fullname;
  List<String> username;
  List<String> phone;
  List<String> accountType;
  List<String> city;
  List<String> password;
  List<String> cPassword;
  List<String> firebaseToken;

  Data(
      {this.fullname,
      this.username,
      this.phone,
      this.accountType,
      this.city,
      this.password,
      this.cPassword,
      this.firebaseToken});

  Data.fromJson(Map<String, dynamic> json) {
    fullname =
        json['fullname'] != null ? json['fullname'].cast<String>() : <String>[];
    username =
        json['username'] != null ? json['username'].cast<String>() : <String>[];
    phone = json['phone'] != null ? json['phone'].cast<String>() : <String>[];
    accountType = json['account_type'] != null
        ? json['account_type'].cast<String>()
        : <String>[];
    city = json['city'] != null ? json['city'].cast<String>() : <String>[];
    password =
        json['password'] != null ? json['password'].cast<String>() : <String>[];
    cPassword = json['c_password'] != null
        ? json['c_password'].cast<String>()
        : <String>[];
    firebaseToken = json['firebaseToken'] != null
        ? json['firebaseToken'].cast<String>()
        : <String>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['account_type'] = this.accountType;
    data['city'] = this.city;
    data['password'] = this.password;
    data['c_password'] = this.cPassword;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
