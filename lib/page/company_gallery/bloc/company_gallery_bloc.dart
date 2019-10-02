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

import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/gallery/gallery_repository.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class CompanyGalleryBloc
    extends Bloc<CompanyGalleryEvent, CompanyGalleryState> {
  final GalleryRepository _galleryRepository;

  CompanyGalleryBloc(this._galleryRepository);

  @override
  CompanyGalleryState get initialState => CompanyGalleryState();

  @override
  Stream<CompanyGalleryState> mapEventToState(
      CompanyGalleryEvent event) async* {
    if (event is LoadCompanyGallery) {
      yield CompanyGalleryLoading();
      try {
        var galleryResponse =
            await _galleryRepository.getCompanyGallery(event.companyId);
        if (galleryResponse.success) {
          var galleryItems = galleryResponse.galleryItems;
          if (galleryItems.isNotEmpty) {
            yield CompanyGalleryLoaded(galleryItems);
          } else {
            yield CompanyGalleryEmpty();
          }
        } else {
          yield CompanyGalleryError();
        }
      } on UnableToConnectException {
        yield CompanyGalleryNetworkError();
      } on TimeoutException {
        yield CompanyGalleryNetworkError();
      } on SessionExpiredException {
        yield CompanyGallerySessionExpired();
      } catch (error) {
        yield CompanyGalleryError();
      }
    }
  }
}
