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

import 'package:Sarh/data/model/category.dart';

class CategoryResponse {
  bool success;
  List<Category> categories;
  String message;

  CategoryResponse({this.success, this.categories, this.message});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      categories = new List<Category>();
      json['data'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categories != null) {
      data['data'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
