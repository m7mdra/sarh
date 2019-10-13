
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/gallery/gallery_repository.dart';
import 'package:Sarh/data/model/company.dart';
import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class MyCompanyGalleryBloc
    extends Bloc<MYCompanyGalleryEvent, MyCompanyGalleryState> {
  final GalleryRepository _galleryRepository;


  Session session;
  MyCompanyGalleryBloc(this._galleryRepository);

  @override
  MyCompanyGalleryState get initialState => MyCompanyGalleryState();

  @override
  Stream<MyCompanyGalleryState> mapEventToState(
      MYCompanyGalleryEvent event) async* {
    print(event);
    if (event is LoadMyCompanyGallery) {
      yield MyCompanyGalleryLoading();
      try {
        var galleryResponse =
        await _galleryRepository.getCompanyGallery(60); //TODO
        if (galleryResponse.success) {
          var galleryItems = galleryResponse.galleryItems;
          if (galleryItems.isNotEmpty) {
            yield MyCompanyGalleryLoaded(galleryItems);
          } else {
            yield MyCompanyGalleryEmpty();
          }
        } else {
          yield MyCompanyGalleryError();
        }
      } on UnableToConnectException {
        yield MyCompanyGalleryNetworkError();
      } on TimeoutException {
        yield MyCompanyGalleryNetworkError();
      } on SessionExpiredException {
        yield MyCompanyGallerySessionExpired();
      } catch (error) {
        print(error);
        yield MyCompanyGalleryError();
      }
    }
  }
}
