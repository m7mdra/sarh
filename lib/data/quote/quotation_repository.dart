import 'dart:io';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/response_status.dart';

class QuotationRepository {
  final Dio _client;

  QuotationRepository(this._client);

  Future<ResponseStatus> createQuote(
      {int requestMethod,
      int accountId,
      int activityId,
      String subject,
      String details,
      List<File> attachments}) async {
    try {
      var formData = FormData.from({
        'request_method': requestMethod,
        'account_id': accountId,
        'activity_id': activityId,
        'subject': subject,
        'details': details,
        'files_attachment': attachments
            .asMap()
            .map((index, file) {
              return MapEntry(index, UploadFileInfo(file, 'file${index+1}'));
            })
            .values
            .toList()
      });

      print(formData.toString());
      /* var response = await _client.post('quotation_requests');

      return ResponseStatus.fromJson(response.data);*/
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