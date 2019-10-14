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

import 'dart:convert';
import 'dart:io';

import 'package:Sarh/data/company/model/company_size_response.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:Sarh/page/add_company_profile/bloc/complete_register/bloc.dart';
import 'package:Sarh/page/my_company_gallery/my_company_gallery.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseStatus> completeRegister(
      CompleteRegistrationModel model) async {
    try {
      model.socialMediaList.removeWhere((media) {
        return media.link == null || media.link.isEmpty;
      });
      var form = FormData();
      model.activities.map((activity) => activity.id).forEach((activity) {
        form.add('activities[0]', activity);
      });
      var formData = FormData.from({
        'start_from': model.startFromDate,
        'about': model.about,
        'employees_size': model.companySize.id,
        'land_phone': model.landPhone,
        'address': model.address,
        'website': model.website,
        'post_code': model.postCode,
        'location': model.location.toString(),
        'activities':
            model.activities.map((activity) => activity.toJson()).toList(),
        'main_category': model.category.id,
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
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseStatus> uploadCompanyImage(File file,String title,String description,{context}) async {
    try {
      FormData formData =
      FormData.from({
        'img'       : new UploadFileInfo(file, 'image'),
        'title'       : title,
        'description' : description
      });
      var response = await _client.post('company_gallareys', data: formData);
      print(response.statusCode);
      return ResponseStatus.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response.statusCode == HTTP_UNAUTHORIZED)
        throw SessionExpiredException();
      else
        throw error;
    } catch (error) {
      throw error;
    }
  }
}
