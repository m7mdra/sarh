
import 'dart:convert';

import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/gallery/gallery_repository.dart';
import 'package:Sarh/data/model/company.dart';
import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCompanyGalleryBloc
    extends Bloc<MYCompanyGalleryEvent, MyCompanyGalleryState> {
  final GalleryRepository _galleryRepository;

  SharedPreferences _preferences ;
 final Session session;
  MyCompanyGalleryBloc(this._galleryRepository, {this.session});

  @override
  MyCompanyGalleryState get initialState => MyCompanyGalleryState();



  @override
  Stream<MyCompanyGalleryState> mapEventToState(
      MYCompanyGalleryEvent event) async* {

    _preferences = await SharedPreferences.getInstance();

    print(event);
    if (event is LoadMyCompanyGallery) {
      yield MyCompanyGalleryLoading();
      try {
//        print(session.company.id);
        var company_id = _preferences.get('company_id');

        var galleryResponse =
        await _galleryRepository.getCompanyGallery(company_id);
        if (galleryResponse.success) {
          var galleryItems = galleryResponse.galleryItems;
          if (galleryItems.isNotEmpty) {
            yield MyCompanyGalleryLoaded(galleryItems);
          } else {
            yield MyCompanyGalleryEmpty();
          }
        } else {
          print(galleryResponse.toString());
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
