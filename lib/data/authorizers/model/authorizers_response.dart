import 'package:Sarh/data/model/authorizer.dart';

class AuthorizerResponse {
  bool success;
  List<Authorizer> data;
  String message;

  AuthorizerResponse({this.success, this.data, this.message});

  AuthorizerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Authorizer>();
      json['data'].forEach((v) {
        data.add(new Authorizer.fromJson(v));
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
