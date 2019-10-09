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
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/community/post_repository.dart';

import 'bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository);

  @override
  PostState get initialState => PostState();

@override
  Stream<PostState> transform(Stream<PostEvent> events, Stream<PostState> Function(PostEvent event) next) {
  return (events as Observable<PostEvent>)
      .debounceTime(Duration(milliseconds: 300))
      .switchMap(next);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPosts) {
      yield* getPosts();
    }
    if (event is OnTagSelected) {
      yield* getPosts(tag: event.tag.name);
    }
    if (event is OnNewPostAdded) {
      if (currentState is PostsLoaded) {
        var postLoadedState = currentState as PostsLoaded;
        var postList = postLoadedState.posts;
        print(event.post.toJson());
        print(postList.map((post) => post.id).toList());
        postList.insert(0, event.post);
        yield PostsLoaded(postList);
      }
    }
    if (event is OnPostLiked) {
      if (currentState is PostsLoaded) {
        var postLoadedState = currentState as PostsLoaded;
        var posts = postLoadedState.posts;
        posts.firstWhere((post) => post.id == event.postId).like = true;
        yield postLoadedState;
      }
    }
    if (event is OnPostUnLiked) {
      if (currentState is PostsLoaded) {
        var postLoadedState = currentState as PostsLoaded;
        var posts = postLoadedState.posts;
        posts.firstWhere((post) => post.id == event.postId).like = false;
        yield postLoadedState;
      }
    }
    if (event is FindPostByKeyword) {
      yield* getPosts(filter: event.keyword);
    }
  }

  Stream<PostState> getPosts({String tag = "", String filter = ""}) async* {
    yield PostsLoading();
    try {
      var response = await _postRepository.getPosts(tag: tag, filter: filter);
      if (response.success) {
        var posts = response.posts;
        if (posts.isNotEmpty) {
          yield PostsLoaded(posts);
        } else {
          yield PostsEmpty();
        }
      } else {
        yield PostsError();
      }
    } on SessionExpiredException {
      yield PostsSessionExpired();
    } on TimeoutException {
      yield PostsTimeout();
    } on UnableToConnectException {
      yield PostsNetworkError();
    } catch (error) {
      yield PostsError();
    }
  }
}
