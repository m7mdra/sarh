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

import 'package:Sarh/data/model/gallery_item.dart';

class GalleryResponse {
  bool success;
  List<GalleryItem> galleryItems;
  String message;

  GalleryResponse({this.success, this.galleryItems, this.message});

  GalleryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      galleryItems = new List<GalleryItem>();
      json['data'].forEach((v) {
        galleryItems.add(new GalleryItem.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.galleryItems != null) {
      data['data'] = this.galleryItems.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}
