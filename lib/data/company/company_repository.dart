import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:Sarh/data/company/model/company_clients_response.dart';
import 'package:Sarh/data/company/model/company_size_response.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:Sarh/page/add_company_profile/bloc/complete_register/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class CompanyRepository {
  final Dio _client;

  CompanyRepository(this._client);

  Future<CompanySizeResponse> getCompanySizeRanges() async {
    try {
      var response = await _client.get('company_sizes');
      return CompanySizeResponse.fromJson(response.data);
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
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseStatus> completeRegister(
      CompleteRegistrationModel model) async {
    try {
      var formData = FormData.from({
        'start_from': model.startFromDate,
        'about': model.about,
        'employees_size': model.companySize.id,
        'land_phone': model.landPhone,
        'address': model.address,
        'website': model.website,
        'main_activity': model.activity.id,
        'company_attachments': model.companyAttachments
            .map((attachment) => UploadFileInfo(attachment,
                'attachment${DateTime.now().millisecondsSinceEpoch})'))
            .toList(),
        'socialMedia': jsonEncode(
            model.socialMediaList.map((social) => social.toJson()).toList())
      });
      var response = await _client.post('company-register', data: formData);
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
      }
    } catch (error) {
      throw error;
    }
  }
}
