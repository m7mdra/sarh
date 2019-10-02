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

class AddPostResponse {
  bool success;
  Post post;
  String message;

  AddPostResponse({this.success, this.post, this.message});

  AddPostResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    post = json['data'] != null ? new Post.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.post != null) {
      data['data'] = this.post.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
