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

import 'package:Sarh/data/model/post.dart';

class PostState {}

class PostsLoading extends PostState {}

class PostsNetworkError extends PostState {}

class PostsError extends PostState {}

class PostsEmpty extends PostState {}

class PostsLoaded extends PostState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostsSessionExpired extends PostState {}

class PostsTimeout extends PostState {}

