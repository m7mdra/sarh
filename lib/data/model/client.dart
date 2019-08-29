class Client {
  int id;
  String name;
  String logo;
  String website;
  int accountId;

  Client({this.id, this.name, this.logo, this.website, this.accountId});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    website = json['website'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['website'] = this.website;
    data['account_id'] = this.accountId;
    return data;
  }
  @override
  String toString() {
    return toJson().toString();
  }
}
