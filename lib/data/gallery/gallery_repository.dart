import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/gallery/model/gallery_response.dart';
import 'package:dio/dio.dart';

class GalleryRepository {
  final Dio _client;

  GalleryRepository(this._client);

  Future<GalleryResponse> getGalleries() async {
    try {
    var response=  await _client.get('company_gallareys');
    return GalleryResponse.fromJson(response.data);
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          throw TimeoutException();
          break;
        case DioErrorType.RESPONSE:
          if (error.response.statusCode == HTTP_UNAUTHORIZED)
            throw SessionExpiredException();
          else
            throw error;
          break;
        case DioErrorType.CANCEL:
          throw error;
          break;
        case DioErrorType.DEFAULT:
          throw UnableToConnectException();
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  Future getCompanyGallery(int companyId) {}
}
