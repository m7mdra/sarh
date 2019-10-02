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

import 'dart:io';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/quote/model/my_quotation_response.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/response_status.dart';

class QuotationRepository {
  final Dio _client;

  QuotationRepository(this._client);

  Future<ResponseStatus> requestQuote(
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
              return MapEntry(index, UploadFileInfo(file, 'file${index + 1}'));
            })
            .values
            .toList()
      });

      var response = await _client.post('quotation_requests');

      return ResponseStatus.fromJson(response.data);
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

  Future<QuotationResponse> getQuotations() async {
    try {
      var response = await _client.get('quotation_requests');
      return QuotationResponse.fromJson(response.data);
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
