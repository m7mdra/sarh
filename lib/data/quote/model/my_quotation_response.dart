import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/user.dart';

class MyQuotationResponse {
  bool success;
  List<Data> data;
  String message;

  MyQuotationResponse({this.success, this.data, this.message});

  MyQuotationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  User account;
  Activity activity;
  List<CompanyQuotations> companyQuotations;
  List<String> attachment;

  Data(
      {this.id,
        this.account,
        this.activity,
        this.companyQuotations,
        this.attachment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account =
    json['account'] != null ? new User.fromJson(json['account']) : null;
    activity = json['activity'] != null
        ? new Activity.fromJson(json['activity'])
        : null;
    if (json['companyQuotations'] != null) {
      companyQuotations = new List<CompanyQuotations>();
      json['companyQuotations'].forEach((v) {
        companyQuotations.add(new CompanyQuotations.fromJson(v));
      });
    }
    if (json['attachment'] != null) {
      attachment = new List<Null>();
    /*  json['attachment'].forEach((v) {
        attachment.add(new Null.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    if (this.activity != null) {
      data['activity'] = this.activity.toJson();
    }
    if (this.companyQuotations != null) {
      data['companyQuotations'] =
          this.companyQuotations.map((v) => v.toJson()).toList();
    }
   /* if (this.attachment != null) {
      data['attachment'] = this.attachment.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}



class CompanyQuotations {
  int id;
  int requestId;
  int companyId;
  bool isSeen;

  CompanyQuotations(
      {this.id,
        this.requestId,
        this.companyId,
        this.isSeen,});

  CompanyQuotations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestId = json['request_id'];
    companyId = json['company_id'];
    isSeen = json['is_seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['request_id'] = this.requestId;
    data['company_id'] = this.companyId;
    data['is_seen'] = this.isSeen;
    return data;
  }
}
