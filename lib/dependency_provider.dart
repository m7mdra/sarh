import 'package:Sarh/data/activity/activity_repository.dart';
import 'package:Sarh/data/category/category_repository.dart';
import 'package:Sarh/data/client/client_repository.dart';
import 'package:Sarh/data/country/city_repository.dart';
import 'package:Sarh/data/gallery/gallery_repository.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/authorizers/authorizer_repository.dart';
import 'data/community/post_repository.dart';
import 'data/company/company_repository.dart';
import 'data/quote/quotation_repository.dart';
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
    client.interceptors.add(InterceptorsWrapper(onResponse: (response) {
      if (response.statusCode == 401) {
        session.clear();
        session.reload();
      }
    }));
    client.interceptors.add(TokenInterceptor(session));
    UserRepository userRepository = UserRepository(client);
    CountryRepository countryRepository = CountryRepository(client);
    ActivityRepository activityRepository = ActivityRepository(client);
    CompanyRepository companyRepository = CompanyRepository(client);
    QuotationRepository quotationRepository = QuotationRepository(client);
    ClientRepository clientRepository = ClientRepository(client);
    CategoryRepository categoryRepository = CategoryRepository(client);
    AuthorizersRepository authorizersRepository = AuthorizersRepository(client);
    GalleryRepository galleryRepository = GalleryRepository(client);
    PostRepository postRepository = PostRepository(client);

    _registrar.registerSingleton<Dio>(client);
    _registrar.registerSingleton<Session>(session);
    _registrar.registerFactory<UserRepository>(() => userRepository);
    _registrar.registerFactory<PostRepository>(() => postRepository);
    _registrar.registerFactory<GalleryRepository>(() => galleryRepository);
    _registrar.registerFactory<ClientRepository>(() => clientRepository);
    _registrar.registerFactory<CountryRepository>(() => countryRepository);
    _registrar
        .registerFactory<AuthorizersRepository>(() => authorizersRepository);
    _registrar.registerFactory<CategoryRepository>(() => categoryRepository);
    _registrar.registerFactory<QuotationRepository>(() => quotationRepository);
    _registrar.registerFactory<ActivityRepository>(() => activityRepository);
    _registrar.registerFactory<CompanyRepository>(() => companyRepository);
  }

  static T provide<T>() {
    return _registrar.get<T>();
  }
}
