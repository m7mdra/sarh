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

class UploadImage {}

class AttemptUpload extends UploadImage {
  final String title;
  final String description;
  final File   image;


  AttemptUpload(this.image,this.title, this.description,context);
}


class UploadImageState {}

class IdleState extends UploadImageState {}

class LoadingState extends UploadImageState {}

class NetworkError extends UploadImageState {}

class Timeout extends UploadImageState {}

class UploadError extends UploadImageState {
  final String message;

  UploadError(this.message);
}

class SuccessState extends UploadImageState {}

class FaildState extends UploadImageState {}

