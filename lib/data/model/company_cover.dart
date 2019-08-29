class CompanyCover {
  int id;
  int companyProfileId;
  String coverUrl;
  String coverType;

  CompanyCover({this.id, this.companyProfileId, this.coverUrl, this.coverType});

  CompanyCover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyProfileId = json['company_profile_id'];
    coverUrl = json['cover_url'];
    coverType = json['cover_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_profile_id'] = this.companyProfileId;
    data['cover_url'] = this.coverUrl;
    data['cover_type'] = this.coverType;
    return data;
  }
  @override
  String toString() {
    return toJson().toString();
  }
}