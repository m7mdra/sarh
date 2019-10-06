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

class HotTagsEvent {}

class LoadHotTags extends HotTagsEvent {}
class OnUserSelectedTag extends HotTagsEvent{
  final Tag tag;

  OnUserSelectedTag(this.tag);
}
