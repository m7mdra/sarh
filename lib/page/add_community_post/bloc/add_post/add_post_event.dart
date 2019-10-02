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
import 'dart:io';

class AddPostEvent{}
class SubmitPost extends AddPostEvent{
  final String title;
  final String body;
  final List<File> attachments;
  final List<String> tags;

  SubmitPost(this.title, this.body, this.attachments, this.tags);
}
