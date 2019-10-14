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

import 'package:Sarh/data/model/company.dart';


class Favorite_company {
  bool success;
  List<ResponseData> data;
  String message;

  Favorite_company({this.success, this.data, this.message});

  Favorite_company.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<ResponseData>();
      json['data'].forEach((v) {
        data.add(new ResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ResponseData {
  int id;
  ResponseCompany company;
  int createdAt;

  ResponseData({this.id, this.company, this.createdAt});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company =
        json['company'] != null ? new ResponseCompany.fromJson(json['company']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ResponseCompany {
  UserInfo userInfo;
  Company companyInfo;

  ResponseCompany({this.userInfo, this.companyInfo});

  ResponseCompany.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
companyInfo = json['companyInfo'] != null
        ? new Company.fromJson(json['companyInfo'])
        : null;
    // companyInfo = json['companyInfo'];
        print(companyInfo);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['companyInfo'] = this.companyInfo;
    print(data);
    return data;
  }
}

class UserInfo {
  int id;
  String username;
  String fullName;
  String phone;
  int accountType;
  City city;
  String image;
  int emailVerifiedAt;
  int smsVerifiedAt;
  String verificationCode;
  int isVerified;
  String firebaseToken;

  UserInfo(
      {this.id,
      this.username,
      this.fullName,
      this.phone,
      this.accountType,
      this.city,
      this.image,
      this.emailVerifiedAt,
      this.smsVerifiedAt,
      this.verificationCode,
      this.isVerified,
      this.firebaseToken});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    phone = json['phone'];
    accountType = json['account_type'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    smsVerifiedAt = json['sms_verified_at'];
    verificationCode = json['verificationCode'];
    isVerified = json['isVerified'];
    firebaseToken = json['firebaseToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['account_type'] = this.accountType;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['sms_verified_at'] = this.smsVerifiedAt;
    data['verificationCode'] = this.verificationCode;
    data['isVerified'] = this.isVerified;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}

class City {
  int id;
  String name;
  String arName;
  int countryId;

  City({this.id, this.name, this.arName, this.countryId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arName = json['arName'];
    countryId = json['countryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['arName'] = this.arName;
    data['countryId'] = this.countryId;
    return data;
  }
}