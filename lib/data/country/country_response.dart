import 'package:Sarh/data/model/city.dart';
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
