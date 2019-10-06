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

class PostEvent {}

class LoadPosts extends PostEvent {}

class OnNewPostAdded extends PostEvent {
  final Post post;

  OnNewPostAdded(this.post);
}
class OnPostLiked extends PostEvent{
  final int postId;

  OnPostLiked(this.postId);
}
class OnPostUnLiked extends PostEvent{
  final int postId;

  OnPostUnLiked(this.postId);
}
class OnTagSelected extends PostEvent{
  final Tag tag;

  OnTagSelected(this.tag);
}
class FindPostByKeyword extends PostEvent{
  final String keyword;

  FindPostByKeyword(this.keyword);
}