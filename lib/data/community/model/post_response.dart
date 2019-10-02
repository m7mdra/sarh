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

class PostResponse {
  bool success;
  List<Post> posts;
  String message;

  PostResponse({this.success, this.posts, this.message});

  PostResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      posts = new List<Post>();
      json['data'].forEach((v) {
        posts.add(new Post.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.posts != null) {
      data['data'] = this.posts.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

