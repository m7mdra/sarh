class Activity {
  int id;
  String nameEn;
  String nameAr;
  String img;
  int activityLevel;
  int createdAt;

  Activity(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.img,
      this.activityLevel,
      this.createdAt});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    img = json['img'];
    activityLevel = json['activity_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['img'] = this.img;
    data['activity_level'] = this.activityLevel;
    data['created_at'] = this.createdAt;
    return data;
  }
  @override
  String toString() {
    return toJson().toString();
  }
}
