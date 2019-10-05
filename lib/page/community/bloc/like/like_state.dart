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

class LikeState {}

class PostLiked extends LikeState {
  final int postId;

  PostLiked(this.postId);
}

class PostUnLiked extends LikeState {
  final int postId;

  PostUnLiked(this.postId);
}

class LikeFailed extends LikeState {}

class UnLikedFailed extends LikeState {}
