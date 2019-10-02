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

class TagsState {}

class TagsLoading extends TagsState {}

class TagsEmpty extends TagsState {}

class TagsLoaded extends TagsState {
  final List<Tag> tags;

  TagsLoaded(this.tags);
}

class TagsNetworkError extends TagsState {}

class TagsTimeout extends TagsState {}

class TagsError extends TagsState {}
class TagsSessionExpired extends TagsState{}
