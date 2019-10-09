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

import 'package:Sarh/data/model/city.dart';

class User {
  int id;
  String username;
  String fullName;
  String phone;
  int accountType;
  City city;
  String image;
  int smsVerifiedAt;
  String verificationCode;
  int isVerified;
  String firebaseToken;

  User(
      {this.id,
        this.username,
        this.fullName,
        this.phone,
        this.accountType,
        this.city,
        this.image,
        this.smsVerifiedAt,
        this.verificationCode,
        this.isVerified,
        this.firebaseToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    phone = json['phone'];
    accountType = json['account_type'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    image = json['image'];
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
    data['sms_verified_at'] = this.smsVerifiedAt;
    data['verificationCode'] = this.verificationCode;
    data['isVerified'] = this.isVerified;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
  bool get isAccountVerified => isVerified == 1;

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
