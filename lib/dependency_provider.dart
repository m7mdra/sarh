import 'package:Sarh/data/country/city_repository.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/token_interceptor.dart';

GetIt _registrar = GetIt();
const _url = 'http://skilledtechuae-001-site5.htempurl.com/api/';

class DependencyProvider {
  DependencyProvider._();

  static Future build() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    BaseOptions options = BaseOptions(
      baseUrl: _url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    Session session = Session(sharedPreferences);

    Dio client = Dio(options);
    client.interceptors.add(LogInterceptor(
        responseBody: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        error: true,
        logSize: 2048 * 2));
    client.interceptors.add(TokenInterceptor(session));
    UserRepository userRepository = UserRepository(client);
    CountryRepository countryRepository = CountryRepository(client);

    _registrar.registerSingleton<Dio>(client);
    _registrar.registerSingleton<Session>(session);
    _registrar.registerFactory<UserRepository>(() => userRepository);
    _registrar.registerFactory<CountryRepository>(() => countryRepository);
  }

  static T provide<T>() {
    return _registrar.get<T>();
  }
}
