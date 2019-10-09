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

class FavoriteState {}

class OnLoading extends FavoriteState {}

class OnLoaded extends FavoriteState {
  final List<Post> posts;

  OnLoaded(this.posts);

}

class FavoritePostsNetworkError extends FavoriteState {}

class FavoritePostsError extends FavoriteState {}

class FavoritePostsEmpty extends FavoriteState {}

class FavoritePostsSessionExpired extends FavoriteState {}

class FavoritePostsTimeout extends FavoriteState {}