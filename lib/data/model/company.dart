class Company {
  int id;
  int startFrom;
  String about;
  String landPhone;
  String address;
  String postCode;
  String website;
  String location;
  int employees;
  int clients;
  int projectsDone;
  int createdAt;

  Company(
      {this.id,
        this.startFrom,
        this.about,
        this.landPhone,
        this.address,
        this.postCode,
        this.website,
        this.location,
        this.employees,
        this.clients,
        this.projectsDone,
        this.createdAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startFrom = json['start_from'];
    about = json['about'];
    landPhone = json['land_phone'];
    address = json['address'];
    postCode = json['post_code'];
    website = json['website'];
    location = json['location'];
    employees = json['employees'];
    clients = json['clients'];
    projectsDone = json['projects_done'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_from'] = this.startFrom;
    data['about'] = this.about;
    data['land_phone'] = this.landPhone;
    data['address'] = this.address;
    data['post_code'] = this.postCode;
    data['website'] = this.website;
    data['location'] = this.location;
    data['employees'] = this.employees;
    data['clients'] = this.clients;
    data['projects_done'] = this.projectsDone;
    data['created_at'] = this.createdAt;
    return data;
  }
}
