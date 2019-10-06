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

import 'package:Sarh/page/community/bloc/hot_tags/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/tag/tags_repository.dart';

class HotTagsBloc extends Bloc<HotTagsEvent, HotTagsState> {
  final TagRepository _repository;

  HotTagsBloc(this._repository);

  @override
  HotTagsState get initialState => HotTagsState();

  @override
  Stream<HotTagsState> mapEventToState(HotTagsEvent event) async* {
    if (event is LoadHotTags) {
      yield HotTagsLoadingState();

      try {
        var response = await _repository.getTags(hotTags: true);
        if (response.success) {
          var tags = response.tags;
          yield HotTagsLoadedState(tags);
        } else {
          yield HotTagsErrorState();
        }
      } catch (error) {
        yield HotTagsErrorState();
      }
    }
  }
}
