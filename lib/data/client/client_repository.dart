import 'dart:io';

import 'package:Sarh/data/client/model/company_clients_response.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class ClientRepository {
  final Dio _client;

  ClientRepository(this._client);

  Future<CompanyClientsResponse> getCompanyClients() async {
    try {
      var response = await _client.get('company_clients');
      return CompanyClientsResponse.fromJson(response.data);
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

  Future<ResponseStatus> addClient(
      {String clientName, File logo, String websiteUrl, int accountId}) async {
    try {
      var formData = FormData.from({
        "name": clientName,
        "logo": new UploadFileInfo(logo, 'image'),
        "website": websiteUrl,
        "account_id": accountId
      });
      var response = await _client.post('company_clients', data: formData);
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

  Future<ResponseStatus> deleteClient(int id) async {
    try {
      var response = await _client.delete('company_clients/$id');
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

  Future<ResponseStatus> updateClient(
      {String clientName,
      File logo,
      String websiteUrl,
      int accountId,
      int id}) async {
    try {
      var formData = FormData.from({
        "name": clientName,
        "logo": new UploadFileInfo(logo, 'image'),
        "website": websiteUrl,
        "account_id": accountId
      });
      var response = await _client.put('company_clients/$id', data: formData);
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
}
