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
import 'package:Sarh/page/activity/bloc/bloc.dart';
import 'package:Sarh/page/home/category/bloc/category_event.dart';
import 'package:Sarh/page/home/category/bloc/category_state.dart';
import 'package:Sarh/page/sub_category/bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;
  final SubCategoryBloc subCategoryBloc;
  final ActivityBloc activityBloc;

  CategoryBloc(this._repository, {this.subCategoryBloc, this.activityBloc});

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
    if (event is OnCategorySelectedEvent) {
      var category = event.category;
      if (category.hasDescendant) {
        subCategoryBloc.dispatch(LoadSubCategories(category.id));
        activityBloc.dispatch(HideActivities());
      } else {
        activityBloc.dispatch(LoadActivitiesFromCategory(category.id));
        subCategoryBloc.dispatch(HideSubCategories());
      }
    }
  }
}
