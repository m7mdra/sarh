import 'package:Sarh/data/session.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    _registrar.registerSingleton(() => client);
    _registrar.registerSingleton(() => session);
  }

  static T provide<T>() {
    return _registrar.get<T>();
  }
}
