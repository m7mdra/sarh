import 'dart:collection';

import 'package:Sarh/data/gallery/gallery_repository.dart';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository _galleryRepository;

  GalleryBloc(this._galleryRepository);

  @override
  GalleryState get initialState => GalleryState();

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is LoadGalleries) {
      yield GalleryLoadingState();
      try {
        var response = await _galleryRepository.getGalleries();
        if (response.success) {
          var galleryItems = response.galleryItems;
          if (galleryItems.isNotEmpty) {
            yield GalleryLoadedState(UnmodifiableListView(galleryItems));
          } else {
            yield GalleryEmptyState();
          }
        } else {
          yield GalleryErrorState();
        }
      } on UnableToConnectException {
        yield GalleryNetworkErrorState();
      } on SessionExpiredException {
        yield GallerySessionExpiredState();
      } on TimeoutException {
        yield GalleryNetworkErrorState();
      } catch (error) {
        yield GalleryErrorState();
      }
    }
  }
}
