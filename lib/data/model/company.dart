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
import 'package:Sarh/data/model/company_size.dart';
import 'package:Sarh/data/model/soical_media.dart';

import 'category.dart';
import 'company_cover.dart';

class Company {
  int id;
  int startFrom;
  String about;
  Category category;
  String landPhone;
  String address;
  String postCode;
  String website;
  String location;
  CompanySize companySize;
  List<Client> clients;
  List<CompanyCover> companyCovers;
  List<SocialMedia> socialMedias;
  List<Activity> activities;
  int projectsDone;
  int createdAt;

  Company(
      {this.id,
        this.startFrom,
        this.about,
        this.category,
        this.landPhone,
        this.address,
        this.postCode,
        this.website,
        this.location,
        this.companySize,
        this.clients,
        this.companyCovers,
        this.socialMedias,
        this.activities,
        this.projectsDone,
        this.createdAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startFrom = json['start_from'];
    about = json['about'];
    category = json['main_category'] != null
        ? new Category.fromJson(json['main_category'])
        : null;
    landPhone = json['land_phone'];
    address = json['address'];
    postCode = json['post_code'];
    website = json['website'];
    location = json['location'];
    companySize = json['companySize'] != null
        ? new CompanySize.fromJson(json['companySize'])
        : null;
    if (json['clients'] != null) {
      clients = new List<Client>();
      json['clients'].forEach((v) {
        clients.add(new Client.fromJson(v));
      });
    }
    if (json['companyCover'] != null) {
      companyCovers = new List<Null>();
      json['companyCover'].forEach((v) {
        companyCovers.add(new CompanyCover.fromJson(v));
      });
    }
    if (json['socialMedia'] != null) {
      socialMedias = new List<Null>();
      json['socialMedia'].forEach((v) {
        socialMedias.add(new SocialMedia.fromJson(v));
      });
    }
    if (json['activity'] != null) {
      activities = new List<Null>();
      json['activity'].forEach((v) {
        activities.add(new Activity.fromJson(v));
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
    if (this.category != null) {
      data['main_category'] = this.category.toJson();
    }
    data['land_phone'] = this.landPhone;
    data['address'] = this.address;
    data['post_code'] = this.postCode;
    data['website'] = this.website;
    data['location'] = this.location;
    if (this.companySize != null) {
      data['companySize'] = this.companySize.toJson();
    }
    if (this.clients != null) {
      data['clients'] = this.clients.map((v) => v.toJson()).toList();
    }
    if (this.companyCovers != null) {
      data['companyCover'] = this.companyCovers.map((v) => v.toJson()).toList();
    }
    if (this.socialMedias != null) {
      data['socialMedia'] = this.socialMedias.map((v) => v.toJson()).toList();
    }
    if (this.activities != null) {
      data['activity'] = this.activities.map((v) => v.toJson()).toList();
    }
    data['projects_done'] = this.projectsDone;
    data['created_at'] = this.createdAt;
    return data;
  }
}
