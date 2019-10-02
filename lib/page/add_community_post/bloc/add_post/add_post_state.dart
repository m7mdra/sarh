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

class AddPostState {}

class LoadingState extends AddPostState {}

class ErrorState extends AddPostState {}

class NetworkErrorState extends AddPostState {}

class SuccessState extends AddPostState {
  final Post post;

  SuccessState(this.post);
}

class SessionExpiredState extends AddPostState {}

class TimeoutState extends AddPostState {}
