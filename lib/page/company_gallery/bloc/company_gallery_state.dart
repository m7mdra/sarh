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

class CompanyGalleryState {}

class CompanyGalleryLoading extends CompanyGalleryState {}

class CompanyGalleryNetworkError extends CompanyGalleryState {}

class CompanyGalleryError extends CompanyGalleryState {}

class CompanyGalleryLoaded extends CompanyGalleryState {
  final List<GalleryItem> galleryItems;

  CompanyGalleryLoaded(this.galleryItems);
}

class CompanyGalleryEmpty extends CompanyGalleryState {}

class CompanyGallerySessionExpired extends CompanyGalleryState {}
