import 'package:Sarh/data/category/category_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/bloc/category_state.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;

  CategoryBloc(this._repository);

  @override
  CategoryState get initialState => CategoryIdle();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategories) {
      yield CategoryLoading();
      try {
        var response = await _repository.getCategories();
        if (response.success) {
          if (response.categories.isNotEmpty) {
            yield CategorySuccess(response.categories);
          } else {
            yield CategoryEmpty();
          }
        } else {
          yield CategoryError();
        }
      } on UnableToConnectException {
        yield CategoryNetworkError();
      } on TimeoutException {
        yield CategoryTimeout();
      } on SessionExpiredException {
        yield CategorySessionExpired();
      } catch (error) {
        print(error);
        yield CategoryError();
      }
    }
  }
}
