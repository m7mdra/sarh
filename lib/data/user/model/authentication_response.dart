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

  User get user => data.userInfo;

  String get token => data.token;

  Company get company => data.companyInfo;

  bool get isCompany => user.accountType == 2;

  bool get companyProfileCompleted => isCompany && company != null;
}

class Data {
  String token;
  User userInfo;
  Company companyInfo;

  Data({this.token, this.userInfo, this.companyInfo});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userInfo =
    json['userInfo'] != null ? new User.fromJson(json['userInfo']) : null;
    companyInfo = json['companyInfo'] != null
        ? new Company.fromJson(json['companyInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    if (this.companyInfo != null) {
      data['companyInfo'] = this.companyInfo.toJson();
    }
    return data;
  }
}
