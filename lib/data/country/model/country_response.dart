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

import 'package:Sarh/data/model/country.dart';

class CountryResponse {
  bool success;
  List<Country> countries;
  String message;

  CountryResponse({this.success, this.countries, this.message});

  CountryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      countries = new List<Country>();
      json['data'].forEach((v) {
        countries.add(new Country.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.countries != null) {
      data['data'] = this.countries.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
