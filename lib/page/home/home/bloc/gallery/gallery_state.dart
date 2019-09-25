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
