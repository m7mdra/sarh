import 'city.dart';

class Country {
  int id;
  String name;
  String arName;
  String code;
  String currency;
  List<City> cities;

  Country(
      {this.id, this.name, this.arName, this.code, this.currency, this.cities});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arName = json['arName'];
    code = json['code'];
    currency = json['currency'];
    if (json['cities'] != null) {
      cities = new List<City>();
      json['cities'].forEach((v) {
        cities.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['arName'] = this.arName;
    data['code'] = this.code;
    data['currency'] = this.currency;
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
