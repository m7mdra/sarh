
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

import 'package:Sarh/data/category/category_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/page/sub_category/bloc/bloc.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';
class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final CategoryRepository _repository;

  SubCategoryBloc(this._repository);

  @override
  SubCategoryState get initialState => SubCategoryIdle();

  @override
  Stream<SubCategoryState> mapEventToState(SubCategoryEvent event) async* {
    if (event is LoadSubCategories) {
      yield SubCategoryLoading();
      try {
        var response = await _repository.getSubCategoriesFromParent(event.categoryId);
        if (response.success) {
          if (response.categories.isNotEmpty) {
            yield SubCategorySuccess(response.categories);
          } else {
            yield SubCategoryEmpty();
          }
        } else {
          yield SubCategoryError();
        }
      } on UnableToConnectException {
        yield SubCategoryNetworkError();
      } on TimeoutException {
        yield SubCategoryTimeout();
      } on SessionExpiredException {
        yield SubCategorySessionExpired();
      } catch (error) {
        print(error);
        yield SubCategoryError();
      }
    }
    if(event is HideSubCategories){
      yield HideSubCategoryState();
    }
  }
}
