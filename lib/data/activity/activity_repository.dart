import 'package:Sarh/data/activity/model/activity_response.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class ActivityRepository {
  final Dio _client;

  ActivityRepository(this._client);

  Future<ActivityResponse> getActivities() async {
    try {
      var response = await _client.get('activities');
      return ActivityResponse.fromJson(response.data);
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
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ActivityResponse> getSubActivities(int parentActivity) async {
    try {
      var response = await _client
          .get('sub_activities', queryParameters: {'main': parentActivity});
      return ActivityResponse.fromJson(response.data);
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
      }
    } catch (error) {
      throw error;
    }
  }
}
