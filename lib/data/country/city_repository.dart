import 'package:dio/dio.dart';

import 'city_response.dart';
import 'country_response.dart';

class CountryRepository {
  final Dio _client;

  CountryRepository(this._client);

  Future<CityResponse> getCities([int countryId = 37]) async {
    try {
      var response = await _client.get('cities/$countryId');
      return CityResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }

  Future<CountryResponse> getCountries() async {
    try {
      var response = await _client.get('countries');
      return CountryResponse.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }
}
