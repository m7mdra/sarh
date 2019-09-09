import 'package:Sarh/data/category/model/category_response.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class CategoryRepository {
  final Dio _client;

  CategoryRepository(this._client);

  Future<CategoryResponse> getCategories() async {
    try {
      var response = await _client.get('categories');
      return CategoryResponse.fromJson(response.data);
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
}
