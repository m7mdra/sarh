import 'package:Sarh/data/model/city.dart';

class User {
  int id;
  String username;
  String fullName;
  String phone;
  int accountType;
  City city;
  String image;
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
    data['isVerified'] = this.isVerified;
    data['firebaseToken'] = this.firebaseToken;
    return data;
  }
}
