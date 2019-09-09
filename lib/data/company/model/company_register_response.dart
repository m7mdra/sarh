import 'package:Sarh/data/model/company.dart';

class CompanyRegisterResponse {
  String message;
  bool success;
  Company company;

  CompanyRegisterResponse({this.message, this.success, this.company});

  CompanyRegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    company = json['data'] != null ? new Company.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.company != null) {
      data['data'] = this.company.toJson();
    }
    return data;
  }
}
