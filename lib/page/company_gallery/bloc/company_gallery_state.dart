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
