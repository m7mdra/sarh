class Category {
  int id;
  String nameEn;
  String nameAr;
  String img;
  int _hasActivity;
  int companyCount;

  Category(
      this.id,
      this._hasActivity,
      this.nameEn,
      this.nameAr,
      this.img,
      this.companyCount);

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    _hasActivity = json['hasactivity'];
    companyCount = json['companyCount'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['hasactivity'] = this._hasActivity;
    data['companyCount'] = this.companyCount;
    data['img'] = this.img;
    return data;
  }

  bool get hasDescendant => _hasActivity == 1;
}
