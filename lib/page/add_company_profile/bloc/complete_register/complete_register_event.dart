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

import 'dart:io';

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/category.dart';
import 'package:Sarh/data/model/company_size.dart';
import 'package:Sarh/page/location_picker/location_picker_page.dart';

class CompleteRegisterEvent {}

class CompleteRegistrationModel {
  final String startFromDate;
  final String about;
  final CompanySize companySize;
  final String landPhone;
  final String address;
  final String website;
  final String postCode;
  final Location location;
  final Category category;
  final List<ActivityId> activities;
  final List<File> companyAttachments;
  final List<SocialMedia> socialMediaList;

  CompleteRegistrationModel(
      {this.startFromDate,
      this.about,
      this.companySize,
      this.landPhone,
      this.activities,
      this.location,
      this.postCode,
      this.address,
      this.website,
      this.category,
      this.companyAttachments,
      this.socialMediaList});
}

class SocialMedia {
  final String link;
  final int id;

  SocialMedia({this.link, this.id});

  Map<String, dynamic> toJson() {
    return {'social_media_id': id, 'social_media_link': link};
  }
}

class CompleteRegister extends CompleteRegisterEvent {
  final CompleteRegistrationModel completeRegistrationModel;

  CompleteRegister(this.completeRegistrationModel);
}

class SocialMediaId {
  static final SocialMediaId FACEBOOk = SocialMediaId._(1);
  static final SocialMediaId TWITTER = SocialMediaId._(2);
  static final SocialMediaId INSTAGRAM = SocialMediaId._(3);
  static final SocialMediaId LINKEDIN = SocialMediaId._(4);
  static final SocialMediaId BEHANCE = SocialMediaId._(4);

  final int value;

  SocialMediaId._(this.value);
}

class ActivityId {
  int id;

  ActivityId(this.id);

  ActivityId.fromJson(Map<String, dynamic> json) {
    id = json['activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = this.id;
    return data;
  }
}
