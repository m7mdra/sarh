import 'package:get_it/get_it.dart';

GetIt getIt = GetIt();

class DependencyProvider {
  DependencyProvider._();

  static void build() {

  }

  static T provide<T>() {
    return getIt.get<T>();
  }
}