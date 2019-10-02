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

class CityResponse {
  bool success;
  List<City> cities;
  String message;

  CityResponse({this.success, this.cities, this.message});

  CityResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      cities = new List<City>();
      json['data'].forEach((v) {
        cities.add(new City.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.cities != null) {
      data['data'] = this.cities.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
