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

import 'model/tag_response.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class TagRepository {
  final Dio _client;

  TagRepository(this._client);

  Future<TagsResponse> getTags({String tag, bool hotTags = false}) async {
    try {
      var query = Map<String, dynamic>();
      if (tag != null && tag.isNotEmpty) {
        query['tagName'] = tag;
      }
      if (hotTags) {
        query['filter'] = 'hotTags';
      }

      var response = await _client.get('tags', queryParameters: query);
      return TagsResponse.fromJson(response.data);
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
