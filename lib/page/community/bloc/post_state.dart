import 'dart:collection';

import 'package:Sarh/data/model/post.dart';

class PostState {}

class PostsLoading extends PostState {}

class PostsNetworkError extends PostState {}

class PostsError extends PostState {}

class PostsEmpty extends PostState {}

class PostsLoaded extends PostState {
  final UnmodifiableListView<Post> posts;

  PostsLoaded(this.posts);
}

class PostsSessionExpired extends PostState {}

class PostsTimeout extends PostState {}
