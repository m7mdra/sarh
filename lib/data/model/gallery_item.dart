class GalleryItem {
  int id;
  String title;
  String description;
  String img;
  CompanyReference company;
  int createdAt;

  GalleryItem(
      {this.id,
        this.title,
        this.description,
        this.img,
        this.company,
        this.createdAt});

  GalleryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
    company = json['company'] != null
        ? new CompanyReference.fromJson(json['company'])
        : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CompanyReference {
  int companyId;
  String companyName;
  String companyImage;

  CompanyReference({this.companyId, this.companyName, this.companyImage});

  CompanyReference.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyImage = json['companyImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['companyImage'] = this.companyImage;
    return data;
  }
}
