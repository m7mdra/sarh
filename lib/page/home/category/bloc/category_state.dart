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

import 'package:Sarh/data/model/activity.dart';
import 'package:Sarh/data/model/category.dart';

class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryNetworkError extends CategoryState {}

class CategoryEmpty extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categoryList;

  CategorySuccess(this.categoryList);
}

class CategoryError extends CategoryState {}

class CategoryIdle extends CategoryState {}

class CategoryTimeout extends CategoryState {}

class CategorySessionExpired extends CategoryState {}

