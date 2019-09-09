class Authorizer {
  int id;
  String name;
  String logo;
  int accountId;

  Authorizer({
    this.id,
    this.name,
    this.logo,
    this.accountId,
  });

  Authorizer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['account_id'] = this.accountId;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
