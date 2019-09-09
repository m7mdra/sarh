class Category {
  int id;
  String nameEn;
  String nameAr;
  String img;
  int activityCount;
  int categoryCount;

  Category(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.img,
      this.activityCount,
      this.categoryCount});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    img = json['img'];
    activityCount = json['activityCount'];
    categoryCount = json['CategoryCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['img'] = this.img;
    data['activityCount'] = this.activityCount;
    data['CategoryCount'] = this.categoryCount;
    return data;
  }
}
