class Authorizer {
  int id;
  String name;
  String logo;
  int accountId;
  int createdAt;
  int updatedAt;
  int deletedAt;

  Authorizer(
      {this.id,
        this.name,
        this.logo,
        this.accountId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Authorizer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    accountId = json['account_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['account_id'] = this.accountId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
  @override
  String toString() {
    return toJson().toString();
  }
}
