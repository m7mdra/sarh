import 'package:Sarh/data/model/company.dart';
import 'package:Sarh/data/model/user.dart';

class AuthenticationResponse {
  bool success;
  Data data;
  String message;

  AuthenticationResponse({this.success, this.data, this.message});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['Message'] = this.message;
    return data;
  }

  User get user => data.user;

  Company get company => data.company;
}

class Data {
  String token;
  User user;
  Company company;

  Data({this.token, this.user, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user =
        json['userInfo'] != null ? new User.fromJson(json['userInfo']) : null;
    company = json['companyInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['userInfo'] = this.user.toJson();
    }
    data['companyInfo'] = this.company;
    return data;
  }
}
