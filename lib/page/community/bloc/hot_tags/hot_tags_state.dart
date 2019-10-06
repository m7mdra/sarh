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

class HotTagsState {}

class HotTagsLoadingState extends HotTagsState {}

class HotTagsLoadedState extends HotTagsState {
  final List<Tag> tags;

  HotTagsLoadedState(this.tags);
}
class HotTagsErrorState extends HotTagsState{

}


