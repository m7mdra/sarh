/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/client.dart';
import 'package:Sarh/data/model/soical_media.dart';

import 'company_cover.dart';

class Company {
  int id;
  int startFrom;
  String about;
  int activity;
  String landPhone;
  String address;
  String postCode;
  String website;
  String location;
  int employees;
  List<Client> clients;
  List<CompanyCover> companyCover;
  List<SocialMedia> socialMediaList;
  int projectsDone;
  int createdAt;

  Company(
      {this.id,
      this.startFrom,
      this.about,
      this.activity,
      this.landPhone,
      this.address,
      this.postCode,
      this.website,
      this.location,
      this.employees,
      this.clients,
      this.socialMediaList,
      this.companyCover,
      this.projectsDone,
      this.createdAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startFrom = json['start_from'];
    about = json['about'];
    activity = json['main_activity'];
    landPhone = json['land_phone'];
    address = json['address'];
    postCode = json['post_code'];
    website = json['website'];
    location = json['location'];
    employees = json['employees'];
    if (json['clients'] != null) {
      clients = new List<Client>();
      json['clients'].forEach((v) {
        clients.add(new Client.fromJson(v));
      });
    }
    if (json['socialMedia'] != null) {
      socialMediaList = new List<SocialMedia>();
      json['socialMedia'].forEach((v) {
        socialMediaList.add(new SocialMedia.fromJson(v));
      });
    }
    if (json['companyCover'] != null) {
      companyCover = new List<CompanyCover>();
      json['companyCover'].forEach((v) {
        companyCover.add(new CompanyCover.fromJson(v));
      });
    }
    projectsDone = json['projects_done'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_from'] = this.startFrom;
    data['about'] = this.about;
    data['main_activity'] = this.activity;
    data['land_phone'] = this.landPhone;
    data['address'] = this.address;
    data['post_code'] = this.postCode;
    data['website'] = this.website;
    data['location'] = this.location;
    data['employees'] = this.employees;
    if (this.clients != null) {
      data['clients'] = this.clients.map((v) => v.toJson()).toList();
    }
    if (this.companyCover != null) {
      data['companyCover'] = this.companyCover.map((v) => v.toJson()).toList();
    }
    if (this.socialMediaList != null) {
      data['socialMedia'] =
          this.socialMediaList.map((v) => v.toJson()).toList();
    }

    data['projects_done'] = this.projectsDone;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
