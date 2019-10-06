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

import 'dart:collection';

import 'bloc.dart';
import 'package:Sarh/data/tag/tags_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final TagRepository _repository;

  TagsBloc(this._repository);

  @override
  Stream<TagsState> transform(Stream<TagsEvent> events,
      Stream<TagsState> Function(TagsEvent event) next) {
    return (events as Observable<TagsEvent>)
        .debounceTime(Duration(milliseconds: 300))
        .switchMap(next);
  }

  @override
  TagsState get initialState => TagsState();

  @override
  Stream<TagsState> mapEventToState(TagsEvent event) async* {
    if (event is FindTagWithName) {
      yield TagsLoading();
      try {
        var response = await _repository.getTags(tag: event.name);
        if (response.success) {
          var tags = response.tags;
          if (tags.isNotEmpty) {
            yield TagsLoaded(tags);
          } else {
            yield TagsEmpty();
          }
        } else {
          yield TagsError();
        }
      } on UnableToConnectException {
        yield TagsNetworkError();
      } on SessionExpiredException {
        yield TagsSessionExpired();
      } on TimeoutException {
        yield TagsTimeout();
      } catch (error) {
        print(error);
        yield TagsError();
      }
    }
  }
}
