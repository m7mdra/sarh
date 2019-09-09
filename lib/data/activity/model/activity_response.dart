import 'package:Sarh/data/model/activity.dart';

class ActivityResponse {
  bool success;
  List<Activity> activities;
  String message;

  ActivityResponse({this.success, this.activities, this.message});

  ActivityResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      activities = new List<Activity>();
      json['data'].forEach((v) {
        activities.add(new Activity.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.activities != null) {
      data['data'] = this.activities.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
