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

import 'package:Sarh/data/community/post_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import './bloc.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class FavoritePostBloc extends Bloc<FavoritePostEvent, FavoriteState> {
  final PostRepository _postRepository;

  FavoritePostBloc(this._postRepository);

  @override
  // TODO: implement initialState
  FavoriteState get initialState => FavoriteState();

  @override
  Stream<FavoriteState> mapEventToState(FavoritePostEvent event) async* {
    // TODO: implement mapEventToState

    if (event is OnLoadingFavoritePost) {
      yield* getPosts();
    }
  }

  Stream<FavoriteState> getPosts() async* {
    yield OnLoading();
    try {
      var response = await _postRepository.getFavoriteCompanies();

      print(response.data.toString());
      if (response.success) {
        var posts = response.data;
        if (posts.isNotEmpty) {
          yield OnLoaded(posts);
        } else {
          yield FavoritePostsEmpty();
        }
      } else {
        yield FavoritePostsError();
      }
    } on SessionExpiredException {
      yield FavoritePostsSessionExpired();
    } on TimeoutException {
      yield FavoritePostsTimeout();
    } on UnableToConnectException {
      yield FavoritePostsNetworkError();
    } catch (error) {
      print(error);
      yield FavoritePostsError();
    }
  }
}
