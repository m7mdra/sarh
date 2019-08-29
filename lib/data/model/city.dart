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
  @override
  String toString() {
    return toJson().toString();
  }
}