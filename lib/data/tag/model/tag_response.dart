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

import 'package:Sarh/data/model/post.dart';

class TagsResponse {
  bool success;
  List<Tag> tags;
  String message;

  TagsResponse({this.success, this.tags, this.message});

  TagsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      tags = new List<Tag>();
      json['data'].forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tags != null) {
      data['data'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
