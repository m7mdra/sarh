class Activity {
  int id;
  String nameEn;
  String nameAr;
  String img;
  int createdAt;

  Activity(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.img,
      this.createdAt});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    img = json['img'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['img'] = this.img;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
