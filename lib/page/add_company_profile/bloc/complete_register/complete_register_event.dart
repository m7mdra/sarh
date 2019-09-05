import 'dart:convert';
import 'dart:io';

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/company_size.dart';

class CompleteRegisterEvent {}

class CompleteRegistrationModel {
  final String startFromDate;
  final String about;
  final CompanySize companySize;
  final String landPhone;
  final String address;
  final String website;
  final Activity activity;
  final List<File> companyAttachments;
  final List<SocialMedia> socialMediaList;

  CompleteRegistrationModel(
      {this.startFromDate,
      this.about,
      this.companySize,
      this.landPhone,
      this.address,
      this.website,
      this.activity,
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
