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

import 'package:Sarh/data/model/post.dart';
import 'package:Sarh/page/community/bloc/post/bloc.dart';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/community/post_repository.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final PostRepository _repository;
  final PostBloc _postBloc;

  LikeBloc(this._repository, this._postBloc);

  @override
  LikeState get initialState => LikeState();

  @override
  Stream<LikeState> mapEventToState(LikeEvent event) async* {
    if (event is ToggleLikePostById) {
      Post post = event.post;
      if (post.isLiked) {
        var response = await _repository.likePost(post.id);
        if (response.success) {
          _postBloc.dispatch(OnPostLiked(post.id));
        } else {
          yield LikeFailed();
        }
      } else {
        var response = await _repository.unlikePost(post.id);
        if (response.success) {
          _postBloc.dispatch(OnPostUnLiked(post.id));
        } else {
          yield UnLikedFailed();
        }
      }
    }
  }
}
