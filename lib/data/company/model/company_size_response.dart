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

import 'package:Sarh/data/model/company_size.dart';

class CompanySizeResponse {
  bool success;
  List<CompanySize> sizes;
  String message;

  CompanySizeResponse({this.success, this.sizes, this.message});

  CompanySizeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      sizes = new List<CompanySize>();
      json['data'].forEach((v) {
        sizes.add(new CompanySize.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.sizes != null) {
      data['data'] = this.sizes.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
