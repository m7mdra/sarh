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

class ModifyProfileImageState {}

class Loading extends ModifyProfileImageState {}

class Failed extends ModifyProfileImageState {}

class ImageLoaded extends ModifyProfileImageState {
  final String imageUrl;

  ImageLoaded(this.imageUrl);
}

class SessionExpired extends ModifyProfileImageState {}

class Success extends ModifyProfileImageState {}

class Idle extends ModifyProfileImageState {
  final String url;

  Idle(this.url);
}
