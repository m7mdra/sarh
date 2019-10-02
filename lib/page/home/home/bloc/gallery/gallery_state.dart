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

import 'dart:collection';

import 'package:Sarh/data/model/gallery_item.dart';

class GalleryState {}

class GalleryLoadingState extends GalleryState {}

class GalleryNetworkErrorState extends GalleryState {}
class GallerySessionExpiredState extends GalleryState {}

class GalleryErrorState extends GalleryState {}

class GalleryLoadedState extends GalleryState {
  final UnmodifiableListView<GalleryItem> galleryItems;

  GalleryLoadedState(this.galleryItems);
}

class GalleryEmptyState extends GalleryState {}
