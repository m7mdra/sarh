


import 'package:Sarh/data/model/gallery_item.dart';

class MyCompanyGalleryState {}

class MyCompanyGalleryLoading extends MyCompanyGalleryState {}

class MyCompanyGalleryNetworkError extends MyCompanyGalleryState {}

class MyCompanyGalleryError extends MyCompanyGalleryState {}

class MyCompanyGalleryLoaded extends MyCompanyGalleryState {

  final List<GalleryItem> galleryItems;

  MyCompanyGalleryLoaded(this.galleryItems);
}

class MyCompanyGalleryEmpty extends MyCompanyGalleryState {}

class MyCompanyGallerySessionExpired extends MyCompanyGalleryState {}